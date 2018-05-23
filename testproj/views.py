from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AdminPasswordChangeForm, PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.contrib import messages

from django import forms
from django.shortcuts import render, redirect, render_to_response, get_object_or_404
from django.http import JsonResponse 
from django.template import RequestContext

from social_django.models import UserSocialAuth
from captcha.fields import ReCaptchaField

from snowpenguin.django.recaptcha2.fields import ReCaptchaField
from snowpenguin.django.recaptcha2.widgets import ReCaptchaWidget

from django.views.generic.dates import MonthArchiveView
from django.views.generic.dates import WeekArchiveView

from testproj.models import *
from testproj.forms import *


class FormWithCaptcha(forms.Form):
    captcha = ReCaptchaField()


@login_required
def home(request):
    return render(request, 'home.html')


@login_required
def settings(request):
    user = request.user

    try:
        github_login = user.social_auth.get(provider='github')
    except UserSocialAuth.DoesNotExist:
        github_login = None

    try:
        twitter_login = user.social_auth.get(provider='twitter')
    except UserSocialAuth.DoesNotExist:
        twitter_login = None

    try:
        facebook_login = user.social_auth.get(provider='facebook')
    except UserSocialAuth.DoesNotExist:
        facebook_login = None

    can_disconnect = (user.social_auth.count() > 1 or user.has_usable_password())

    return render(request, 'settings.html', {
        'github_login': github_login,
        'twitter_login': twitter_login,
        'facebook_login': facebook_login,
        'can_disconnect': can_disconnect
    })


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
    Return list of all ideas
    '''
    ideas_list = Ideas.objects.all() #every object of list have: 
    for idea in ideas_list:
        idea.like_qty = idea.likes.count()
    context = {'ideas_list': ideas_list}
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
    profile = ExtendedUser.objects.get(user__username=username)
    context = {'profile': profile}
    return render(request, 'testproj/user.html', context)

@login_required
def profile(request):
    '''
    Return user\'s own profile
    '''
    profile = ExtendedUser.objects.get(user__username=request.user.username)
    context = {'profile': profile}
    return render(request, 'testproj/profile.html', context)


@login_required
def add_post(request):
    request_context = RequestContext(request)
    form = IdeasForm(request.POST or None)
    if form.is_valid():
        post = form.save(commit=False)
        post.author = request.user
        post.save()
        return redirect(post)
    return render(request,  'text.html',
                  {'form': form}, request_context)


def view_post(request, slug):
    post = get_object_or_404(Ideas, slug=slug)
    return render_to_response('text.html',
                              {
                                  # 'post': post,
                                  # 'form': form,
                              }, context_instance=RequestContext(request))


class IdeasMonthArchiveView(MonthArchiveView):
    queryset = Ideas.objects.all()
    date_field = "pub_date"
    allow_future = False


class IdeasWeekArchiveView(WeekArchiveView):
    queryset = Ideas.objects.all()
    date_field = "pub_date"
    week_format = "%W"
    allow_future = False

