"""slytherinideas URL Configuration

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
from django.urls import path, re_path, include
from .views import RegisterFormView
from .views import LoginFormView, hello
from django.contrib.auth import views as auth_views

admin.autodiscover()

urlpatterns = [
    path('admin/', admin.site.urls),
    path(r'register/', RegisterFormView.as_view()),
    path(r'login/', LoginFormView.as_view()),
    #path(r'/', hello),
    # re_path(r'^password_reset/$', auth_views.password_reset, name='password_reset'),
    # re_path(r'^password_reset/done/$', auth_views.password_reset_done, name='password_reset_done'),
    # re_path(r'^reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/$',
    #     auth_views.password_reset_confirm, name='password_reset_confirm'),
    # re_path(r'^reset/done/$', auth_views.password_reset_complete, name='password_reset_complete'),

    re_path('^', include('django.contrib.auth.urls')),

    # re_path(r'^user/password/reset/$',
    #     'django.contrib.auth.views.password_reset', {'post_reset_redirect' : '/user/password/reset/done/'},
    #     name="password_reset"),
    # re_path(r'^user/password/reset/done/$', 'django.contrib.auth.views.password_reset_done'),
    # re_path(r'^user/password/reset/(?P<uidb36>[0-9A-Za-z]+)-(?P<token>.+)/$', 'django.contrib.auth.views.password_reset_confirm',
    #     {'post_reset_redirect' : '/user/password/done/'}),
    # re_path(r'^user/password/done/$', 'django.contrib.auth.views.password_reset_complete'),

]
