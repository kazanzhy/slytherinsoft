from django import forms
from testproj.models import Ideas
from django.forms import ModelForm, Textarea
from django_summernote.widgets import SummernoteWidget, SummernoteInplaceWidget


class SomeForm(forms.Form):
    content = forms.CharField(widget=SummernoteWidget())  # instead of forms.Textarea


class IdeasForm(ModelForm):
    # text = forms.CharField(widget=forms.Textarea, label='Entry')
    content = forms.CharField(widget=SummernoteWidget())
   # text = forms.CharField(widget=TinyMCEWidget(attrs={'cols': 80, 'rows': 30}), label='Entry')
    class Meta:
        model = Ideas
        exclude = ['likes']
        widgets = {
            'foo': SummernoteWidget(),
            'bar': SummernoteInplaceWidget(),
        }
