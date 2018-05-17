from django.contrib import admin
from .models import *

admin.site.register(IdeaStatus)
admin.site.register(Role)
admin.site.register(ExtendedUser)
admin.site.register(Ideas)

