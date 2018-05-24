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


def ideas(request, page_number):
    '''
    Return list of all approved ideas
    '''
    if request.method == 'POST':
        form = IdeasForm(request.user, request.POST)
        if form.is_valid(): 
            pass
    else:
        form = IdeasForm()
    ideas_list = Ideas.objects.filter(is_approved=True).order_by('-likes') #every object of list have:
    for idea in ideas_list:
        idea.like_qty = idea.likes.count()
    #pages = Paginator(ideas_list, 10) # 10 ideas on one page
    #if page_number in pages.page_range:
        #ideas_list = pages.page(page_number)
    #else:
        #ideas_list = pages.page(1)
    #context = {'ideas_list': ideas_list, 'page_number': page_number} # ideas_list have .has_previous() and .has_next()
    context = {'ideas_list': ideas_list}
    content = Ideas.content
    return render(request, 'testproj/ideas.html', context)

@login_required
def new(request, page_number):
    '''
    Return list of all not approved ideas
    '''
    if request.method == 'POST':
        form = IdeasForm(request.user, request.POST)
        if form.is_valid():
            pass
    else:
        form = IdeasForm()
    ideas_list = Ideas.objects.filter(is_approved=False).order_by('-edit_date')
    #pages = Paginator(ideas_list, 10) # 10 ideas on one page
    #if page_number in pages.page_range:
        #ideas_list = pages.page(page_number)
    #else:
        #ideas_list = pages.page(1)
    #context = {'ideas_list': ideas_list, 'page_number': page_number} # ideas_list have .has_previous() and .has_next()
    context = {'ideas_list': ideas_list} # {'pages': pages, 'num_pages': pages.num_pages}
    content = Ideas.content
    return render(request, 'testproj/new.html', context)

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

