from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AdminPasswordChangeForm, PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.contrib import messages

from django import forms
from django.shortcuts import render, redirect, render_to_response, get_object_or_404
from django.http import JsonResponse 
from django.template import RequestContext
from django.core.paginator import Paginator
# from captcha.fields import ReCaptchaField

# from snowpenguin.django.recaptcha2.fields import ReCaptchaField
# from snowpenguin.django.recaptcha2.widgets import ReCaptchaWidget

from django.views.generic.dates import MonthArchiveView
from django.views.generic.dates import WeekArchiveView

from .models import *
from .forms import *


# class FormWithCaptcha(forms.Form):
#     captcha = ReCaptchaField()


@login_required
def home(request):
    return render(request, 'home.html')


@login_required
def password(request):
    if request.user.has_usable_password():
        PasswordForm = PasswordChangeForm
    else:
        PasswordForm = AdminPasswordChangeForm

    if request.method == 'POST':
        form = PasswordForm(request.user, request.POST)
        if form.is_valid():
            form.save()
            update_session_auth_hash(request, form.user)
            messages.success(request, 'Your password was successfully updated!')
            return redirect('password')
        else:
            messages.error(request, 'Please correct the error below.')
    else:
        form = PasswordForm(request.user)
    return render(request, 'password.html', {'form': form})


def ideas(request):
    '''
    Return list of all approved ideas
    '''
    if 'display' in request.GET and request.GET['display'] == 'best':
        ideas_list = Ideas.objects.filter(is_approved=True).order_by('-create_date', '-likes')[:30]
        current_page = 1
        num_pages = [1]
    else:
        if 'page' in request.GET:
            current_page = int(request.GET['page'])
        else:
            current_page = 1  
        ideas_list = Ideas.objects.filter(is_approved=True)
        pages = Paginator(ideas_list, 30) # 30 ideas on one page
        if current_page not in pages.page_range:
            current_page = 1
        ideas_list = pages.page(current_page) # ideas_list have .has_previous() and .has_next()
        num_pages = pages.page_range
    for idea in ideas_list:
        idea.like_qty = idea.likes.count()
    context = {'ideas_list': ideas_list, 'current_page': current_page, 'num_pages': num_pages} 
    return render(request, 'testproj/ideas.html', context)


def idea(request, idea_id):
    '''
    Return one idea with selected number
    '''
    idea = get_object_or_404(Ideas, pk=idea_id)
    idea.views += 1
    idea.save()
    idea.like_qty = idea.likes.count()
    context = {'idea': idea}
    return render(request, 'testproj/idea.html', context)

@login_required
def like(request, idea_id):
    '''
    Put like
    '''
    idea = get_object_or_404(Ideas, pk=idea_id)
    if request.user in idea.likes.all():
        idea.likes.remove(request.user)
        liked = False
    else:
        idea.likes.add(request.user)
        liked = True
    idea.save()
    context = {'liked': liked, 'idea_id': idea_id, 'likes': idea.likes.count()}
    return JsonResponse(context)


def user(request, username):
    '''
    Return profile of selected user
    '''
    user = User.objects.get(username=username)
    profile = ExtendedUser.objects.get(user=user)
    ideas = Ideas.objects.filter(author=user)
    context = {'profile': profile, 'ideas': ideas}
    return render(request, 'testproj/user.html', context)


@login_required
def profile(request):
    '''
    Return user\'s own profile
    '''
    profile = ExtendedUser.objects.get(user__username=request.user.username)
    ideas = Ideas.objects.filter(author=request.user)
    context = {'profile': profile, 'ideas': ideas}
    return render(request, 'testproj/profile.html', context)


class IdeasMonthArchiveView(MonthArchiveView):
    queryset = Ideas.objects.all()
    date_field = "pub_date"
    allow_future = False


class IdeasWeekArchiveView(WeekArchiveView):
    queryset = Ideas.objects.all()
    date_field = "pub_date"
    week_format = "%W"
    allow_future = False

