from django.db import models
from django.contrib.auth.models import User


class IdeaStatus(models.Model):
    '''
    Idea statuses. One row - one status (just created, approved, declined)
    '''
    status = models.CharField(unique=True, max_length=255, blank=True)

    def __str__(self):
        return self.status
    
    class Meta:
        db_table = 'ideastatus'
        verbose_name = "Idea Status"
        verbose_name_plural = "Idea Statuses"


class Role(models.Model):
    '''
    Roles of users. One row - one role (architect, moderator, user, banned)
    '''
    role = models.CharField(unique=True, max_length=255, blank=True)

    def __str__(self):
        return self.role

    class Meta:
        db_table = 'roles'
        verbose_name = "Roles"
        verbose_name_plural = "Roles"


class ExtendedUser(models.Model):
    '''
    Users. Extends of standard model
    '''
    user = models.OneToOneField(User, on_delete=models.CASCADE) # Standart User model
    role = models.ForeignKey(Role, on_delete=models.CASCADE, related_name='role_id', blank=True)
    is_verified = models.BooleanField(default=False)

    def __str__(self):
        return '{} ({})'.format(self.user, self.role, self.is_verified)

    class Meta:
        db_table = 'extendeduser'
        verbose_name = "Extended User"
        verbose_name_plural = "Extended Users"


class Ideas(models.Model):
    '''
    Ideas. 
    '''
    title = models.CharField(max_length=255) #unique=True)
    cover = models.ImageField(upload_to='uploads/%Y/%m/%d/', blank=True)
    content = models.TextField()
    status = models.ForeignKey(IdeaStatus, on_delete=models.CASCADE, related_name='status_id')
    author = models.ForeignKey(ExtendedUser, on_delete=models.CASCADE, related_name='author_id')
    moderator = models.ForeignKey(ExtendedUser, on_delete=models.CASCADE, related_name='moderator_id', null=True, blank=True)
    create_date = models.DateTimeField(auto_now_add=True)
    edit_date = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(User, default=0)
    views = models.PositiveIntegerField(default=1)

    def __str__(self):
        return '"{}" by "{}" now is {}'.format(self.title, self.author, self.status)

    class Meta:
        db_table = 'ideas'
        verbose_name = "Ideas"
        verbose_name_plural = "Ideas"






