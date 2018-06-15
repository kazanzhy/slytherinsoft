from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AdminPasswordChangeForm, PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.contrib import messages
from django.http import HttpResponseRedirect
from django import forms
from django.shortcuts import render, redirect, render_to_response, get_object_or_404, HttpResponse
from django.http import JsonResponse 
from django.template import RequestContext
from django.core.paginator import Paginator

from django.views.generic.dates import MonthArchiveView
from django.views.generic.dates import WeekArchiveView

from .models import *
from .forms import *
from django.contrib.auth.models import User
from django.db.models.signals import pre_save
from django.db.models import Count

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
    return render(request, 'registration/password.html', {'form': form})


def home(request):
    ideas_list = Ideas.objects.filter(status='a').annotate(num_likes=Count('likes')).order_by('-create_date', '-num_likes')[:30]
    for idea in ideas_list:
        idea.view_qty = idea.views.count()
        idea.like_qty = idea.likes.count()
    context = {'ideas_list': ideas_list} 
    return render(request, 'home.html', context)


def ideas(request):
    '''
    Return list of all approved ideas
    '''
    if 'page' in request.GET:
        current_page = int(request.GET['page'])
    else:
        current_page = 1  
    ideas_list = Ideas.objects.filter(status='a').order_by('-create_date')
    pages = Paginator(ideas_list, 30) # 30 ideas on one page
    if current_page not in pages.page_range:
        current_page = 1
    ideas_list = pages.page(current_page) # ideas_list have .has_previous() and .has_next()
    num_pages = pages.page_range
    for idea in ideas_list:
        idea.view_qty = idea.views.count()
        idea.like_qty = idea.likes.count()
    context = {'ideas_list': ideas_list, 'current_page': current_page, 'num_pages': num_pages} 
    return render(request, 'ideas.html', context)

def best(request):
    '''
    Return list of all approved ideas
    '''
    if 'page' in request.GET:
        current_page = int(request.GET['page'])
    else:
        current_page = 1  
    ideas_list = Ideas.objects.filter(status='a').annotate(num_likes=Count('likes')).order_by('-num_likes')
    pages = Paginator(ideas_list, 30) # 30 ideas on one page
    num_pages = pages.page_range
    for idea in ideas_list:
        idea.view_qty = idea.views.count()
        idea.like_qty = idea.likes.count()
    context = {'ideas_list': ideas_list, 'current_page': current_page, 'num_pages': num_pages} 
    return render(request, 'ideas.html', context)


def idea(request, idea_id):
    '''
    Return one idea with selected number
    '''
    idea = get_object_or_404(Ideas, pk=idea_id)
    if request.user not in idea.views.all():
        idea.views.add(request.user)
    idea.save()
    idea.like_qty = idea.likes.count()
    idea.view_qty = idea.views.count()
    idea.is_liked = request.user in idea.likes.all()
    can_edit = request.user == idea.author
    is_moderator = Profile.objects.get(user__username=request.user.username).is_moderator
    context = {'idea': idea, 'is_moderator': is_moderator, 'can_edit': can_edit}
    return render(request, 'idea.html', context)


@login_required
def like(request):
    '''
    Put like
    '''
    action = request.GET['action']
    idea_id = int(request.GET['id'])
    idea = get_object_or_404(Ideas, pk=idea_id)
    if action == 'like':
        if request.user in idea.likes.all():
            idea.likes.remove(request.user)
            notif = Notifications(user=idea.author, moderator=request.user, idea=idea, text='unliked')
        else:
            idea.likes.add(request.user)
            notif = Notifications(user=idea.author, moderator=request.user, idea=idea, text='liked')
    elif action == 'approve':
        idea.status = 'a'
        notif = Notifications(user=idea.author, moderator=request.user, idea=idea, text='approved')
    elif action == 'decline':
        idea.status = 'd'
        notif = Notifications(user=idea.author, moderator=request.user, idea=idea, text='declined')
    notif.save()
    idea.save()
    return redirect('/idea/{}/'.format(idea_id))


def user(request, username):
    '''
    Return profile of selected user
    '''
    user = User.objects.get(username=username)
    profile = Profile.objects.get(user=user)
    ideas = Ideas.objects.filter(author=user, status='a')
    context = {'profile': profile, 'ideas': ideas}
    return render(request, 'user.html', context)


@login_required
def profile(request):
    '''
    Return user\'s own profile
    '''
    profile = Profile.objects.get(user__username=request.user.username)
    ideas = Ideas.objects.filter(author=request.user)
    context = {'profile': profile, 'ideas': ideas}
    return render(request, 'profile.html', context)

@login_required
def edit_profile(request):
    '''
    Return user\'s own profile
    '''
    profile = get_object_or_404(Profile, pk=request.user.pk)
    if request.method == 'POST':
        form = EditForm(request.POST)
        if form.is_valid():
            profile.firstname = form.cleaned_data['firstname']
            profile.lastname = form.cleaned_data['lastname']
            profile.city = form.cleaned_data['city']
            profile.bio = form.cleaned_data['bio']
            profile.save()
            return redirect('/profile/my')
    else:
        form = EditForm(initial={'firstname': profile.firstname, 'lastname': profile.lastname, 'city': profile.city, 'bio': profile.bio})
        return render(request, 'edit.html', {'form': form})


# add new idea if user is authorized
@login_required
def add_idea(request):
    if request.method == 'POST':
        form = IdeaForm(request.POST, request.FILES)
        if form.is_valid():
            idea = Ideas()
            idea.title = form.cleaned_data['title']
            idea.cover = form.cleaned_data['cover']
            idea.content = form.cleaned_data['content']
            idea.author = request.user
            if 'save_idea' in request.POST:
                idea.status = 's'
            else:
                idea.status = 'p'
            idea.save()
            return redirect('/idea/{}'.format(idea.pk))
    else:
        form = IdeaForm()
        return render(request, 'add.html', {'form': form})


@login_required
def edit_idea(request, idea_id):
    idea = get_object_or_404(Ideas, pk=idea_id)
    if request.method == 'POST':
        form = IdeaForm(request.POST, request.FILES)
        if form.is_valid():
            idea.title = form.cleaned_data['title']
            idea.cover = form.cleaned_data['cover']
            idea.content = form.cleaned_data['content']
            if 'save_idea' in request.POST:
                idea.status = 's'
            else:
                idea.status = 'p'
            idea.save()
            return redirect('/idea/{}'.format(idea.pk))
    else:
        form = IdeaForm(initial={'title': idea.title, 'cover': idea.cover, 'content': idea.content})
        return render(request, 'add.html', {'form': form})


@login_required
def notifications(request):
    '''
    Return notifications for user
    '''
    notifications = Notifications.objects.filter(user__username=request.user.username).order_by('-create_date')[:30]
    context = {'notifications': notifications}
    return render(request, 'notifications.html', context)

@login_required
def approvement(request):
    '''
    Return list of all approved ideas
    '''
    if 'page' in request.GET:
        current_page = int(request.GET['page'])
    else:
        current_page = 1  
    ideas_list = Ideas.objects.filter(status='p')
    pages = Paginator(ideas_list, 30) # 30 ideas on one page
    num_pages = pages.page_range
    for idea in ideas_list:
        idea.view_qty = idea.views.count()
        idea.like_qty = idea.likes.count()
    context = {'ideas_list': ideas_list, 'current_page': current_page, 'num_pages': num_pages} 
    return render(request, 'ideas.html', context)


class IdeasMonthArchiveView(MonthArchiveView):
    queryset = Ideas.objects.all()
    date_field = "pub_date"
    allow_future = False


class IdeasWeekArchiveView(WeekArchiveView):
    queryset = Ideas.objects.all()
    date_field = "pub_date"
    week_format = "%W"
    allow_future = False






