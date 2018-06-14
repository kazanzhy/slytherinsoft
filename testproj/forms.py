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
    firstname = forms.CharField(label='First name', required = False)
    lastname = forms.CharField(label='Last name', required = False)
    city = forms.CharField(label='City', required = False)
    bio = forms.CharField(label='Biography', widget=forms.Textarea, required = False)
    class Meta:
        model = Profile
        exclude = ['user', 'is_moderator', 'is_verified']
