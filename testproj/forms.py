from django import forms
from testproj.models import *
from django.forms import ModelForm, Textarea
from django_summernote.widgets import SummernoteWidget, SummernoteInplaceWidget


class IdeaForm(ModelForm):
    title = forms.CharField(label='Idea title')
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
    firstname = forms.CharField(label='First name')
    lastname = forms.CharField(label='Last name')
    city = forms.CharField(label='City')
    bio = forms.CharField(label='Biography', widget=forms.Textarea)
    class Meta:
        model = Profile
        exclude = ['user', 'is_moderator', 'is_verified']
