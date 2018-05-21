from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AdminPasswordChangeForm, PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.contrib import messages
from django.shortcuts import render, redirect

from social_django.models import UserSocialAuth
from django import forms
from captcha.fields import ReCaptchaField

from snowpenguin.django.recaptcha2.fields import ReCaptchaField
from snowpenguin.django.recaptcha2.widgets import ReCaptchaWidget

from .models import *
from django.http import HttpResponse # For test

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


def all_ideas(request):
    '''
    Return list of all ideas
    '''
    i_list = Ideas.objects.all() #every object of list have: 
    #context = {'ideas_list': i_list}
    #return render(request, 'ideas.html', context)
    return HttpResponse('<p></p>'.join(map(str, i_list))) # For test


def idea(request, idea_id):
    '''
    Return one idea with selected number
    '''
    try: 
        idea_id = int(idea_id)
    except:
        return HttpResponse('Not correct url') # For test
    else:
        if int(idea_id) < 1 or int(idea_id) > len (Ideas.objects.all()): 
            return HttpResponse('This idea isn\'t created') # For test
        else:
            idea = Ideas.objects.get(id=idea_id)
            return HttpResponse(str(idea)) # For test

    #context = {'idea': idea}
    #return render(request, 'idea.html', context)
    return HttpResponse(str(idea)) # For test


class FormWithCaptcha(forms.Form):
    captcha = ReCaptchaField()







