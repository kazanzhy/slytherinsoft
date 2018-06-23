from django import forms
from testproj.models import *
from django.forms import ModelForm, Textarea
from django_summernote.widgets import SummernoteWidget, SummernoteInplaceWidget


class IdeaForm(ModelForm):
    '''
    Form for idea creating
    '''
    title = forms.CharField(label='Idea title', max_length=200)
    cover = forms.ImageField(required = False)
    content = forms.CharField(label='Idea description', widget=SummernoteWidget())
    class Meta:
        model = Ideas
        exclude = ['likes', 'author', 'is_approved', 'views', 'status']
        widgets = {
            'foo': SummernoteWidget(),
            'bar': SummernoteInplaceWidget(),
        }

class EditForm(ModelForm):
    '''
    Form for editing of user info
    '''
    firstname = forms.CharField(label='First name', required = False, max_length=200)
    lastname = forms.CharField(label='Last name', required = False, max_length=200)
    city = forms.CharField(label='City', required = False, max_length=200)
    bio = forms.CharField(label='Biography', widget=forms.Textarea, required = False, max_length=5000)
    class Meta:
        model = Profile
        exclude = ['user', 'is_moderator', 'is_verified']
