from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AdminPasswordChangeForm, PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.contrib import messages
from django.shortcuts import render, redirect, get_object_or_404

from social_django.models import UserSocialAuth
from django import forms
from captcha.fields import ReCaptchaField

from snowpenguin.django.recaptcha2.fields import ReCaptchaField
from snowpenguin.django.recaptcha2.widgets import ReCaptchaWidget

from .models import *
from django.http import JsonResponse #, HttpResponse # For test

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
    print
    return render(request, 'testproj/idea.html', context)


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


class FormWithCaptcha(forms.Form):
    captcha = ReCaptchaField()







