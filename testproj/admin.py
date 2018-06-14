from django.contrib import admin
from django_summernote.admin import SummernoteModelAdmin
from .models import *

class QuestionAdmin(SummernoteModelAdmin):
    pass  # you can add more overrides to the Admin Form but this is all that is needed for overriding the Textfield


admin.site.register(Profile)
admin.site.register(Ideas)
admin.site.register(Notifications)

# admin.site.register(Question, QuestionAdmin)
