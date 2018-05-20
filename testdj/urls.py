"""testdj URL Configuration
The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.contrib import admin
from django.urls import path, include, re_path
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views

from testproj import views
# from testproj.core import views as core views
admin.autodiscover()

urlpatterns = [
    path('admin/', admin.site.urls),
    re_path(r'^accounts/', include('allauth.urls')),
    re_path(r'^account_login/$', auth_views.login, name='registration/login'),
    re_path(r'^account_logout/$', auth_views.logout, name='logout'),
    # re_path(r'^oauth/', include('social_django.urls', namespace='social')),  # <--
    re_path(r'^$', views.home, name='home'),
    re_path(r'^ideas/$', views.all_ideas, name='ideas'),
    re_path(r'^idea/(?P<idea_id>[0-9]+)$', views.idea, name='idea'),
]

LOGIN_URL = 'login'
LOGOUT_URL = 'logout'
LOGIN_REDIRECT_URL = 'home'


urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
