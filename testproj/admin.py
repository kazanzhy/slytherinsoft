from django.contrib import admin
from django_summernote.admin import SummernoteModelAdmin
from .models import *

class QuestionAdmin(SummernoteModelAdmin):
    pass  # you can add more overrides to the Admin Form but this is all that is needed for overriding the Textfield


admin.site.register(ExtendedUser)
admin.site.register(Ideas, QuestionAdmin)

# admin.site.register(Question, QuestionAdmin)
