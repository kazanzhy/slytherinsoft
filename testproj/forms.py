from django import forms
from testproj.models import Ideas
from django.forms import ModelForm, Textarea
from tinymce.widgets import TinyMCE


class TinyMCEWidget(TinyMCE):
    def use_required_attribute(self, *args):
        return False


class IdeasForm(ModelForm):
    # text = forms.CharField(widget=forms.Textarea, label='Entry')
    text = forms.CharField(widget=TinyMCEWidget(attrs={'cols': 80, 'rows': 30}), label='Entry')
    class Meta:
        model = Ideas
        exclude = ['likes']
