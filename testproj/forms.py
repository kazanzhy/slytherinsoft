from django import forms
from testproj.models import Ideas
from django.forms import ModelForm, Textarea
from django_summernote.widgets import SummernoteWidget, SummernoteInplaceWidget


class IdeaForm(ModelForm):
    title = forms.CharField(label='Idea title')
    cover = forms.ImageField()
    content = forms.CharField(label='Idea description', widget=SummernoteWidget())
    class Meta:
        model = Ideas
        exclude = ['likes', 'author', 'is_approved', 'views', 'status']
        widgets = {
            'foo': SummernoteWidget(),
            'bar': SummernoteInplaceWidget(),
        }

class AddIdeaAuthorized(forms.Form):
    ideaadd_title_auth = forms.CharField(label='Idea Title: ', max_length=100)
    ideaadd_text_auth = forms.CharField(label='Idea Text: ', widget=SummernoteWidget())
    ideaadd_cover_auth = forms.ImageField()

