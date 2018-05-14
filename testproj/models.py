from django.db import models
from django.contrib.auth.models import User


class IdeaStatus(models.Model):
    '''
    Статусы идей. Каждая трока - один статус (только создано, подтверждено, отклонено)
    '''
    status = models.CharField(unique=True, max_length=255)
    class Meta:
        db_table = 'statuses'


class Role(models.Model):
    '''
    Роли пользователей. Каждая трока - одна роль (архитектор, модератор, пользователь, забаненный)
    '''
    status = models.CharField(unique=True, max_length=255)
    class Meta:
        db_table = 'roles'


class Extenden_User(models.Model):
    '''
    База пользователей. Расширяет стандартную модель
    '''
    user = models.OneToOneField(User, on_delete=models.CASCADE) # Standart User model
    role = models.ForeignKey(Role, on_delete=models.CASCADE)
    is_verified = models.BooleanField()
    class Meta:
        db_table = 'users'


class Ideas(models.Model):
    '''
    Идеи. Каждая строка - одна идея
    '''
    title = models.CharField(max_length=255) #unique=True) ???
    cover = models.ImageField(upload_to = 'uploads/%Y/%m/%d/', blank=True)
    content = models.TextField()
    status = models.ForeignKey(IdeaStatus, on_delete=models.CASCADE)
    author = models.ForeignKey(Extenden_User, on_delete=models.CASCADE)
    create_date = models.DateTimeField()
    edit_date = models.DateTimeField()
    class Meta:
        db_table = 'ideas'


class Likes(models.Model):
    '''
    Лайки. Каждая строка - лайк одного пользователя одной идее
    '''
    user = models.ForeignKey(Extenden_User, on_delete=models.CASCADE)
    idea = models.ForeignKey(Ideas, on_delete=models.CASCADE)
    create_date = models.DateTimeField()
    class Meta:
        db_table = 'likes'


class Views(models.Model):
    '''
    Просмотры. Каждая строка - просмотр одной идеи одним пользователем
    '''
    user = models.ForeignKey(Extenden_User, on_delete=models.CASCADE)
    idea = models.ForeignKey(Ideas, on_delete=models.CASCADE)
    create_date = models.DateTimeField()
    class Meta:
        db_table = 'views'


