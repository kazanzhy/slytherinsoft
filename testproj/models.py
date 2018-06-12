from django.db import models
from django.contrib.auth.models import User

from django.template.defaultfilters import slugify
from django.db.models.signals import post_save
from django.dispatch import receiver

class Profile(models.Model):
    '''
    Users. Extends of standard model
    '''
    user = models.OneToOneField(User, on_delete=models.CASCADE) # Standart User model
    firstname = models.CharField(max_length=255, blank=True, help_text="Enter your firstname")
    lastname = models.CharField(max_length=255, blank=True, help_text="Enter your lastname")
    city = models.CharField(max_length=255, blank=True, help_text="Enter city where you live")
    bio = models.TextField(blank=True, help_text="Enter some info about you")
    is_moderator = models.BooleanField(default=False)
    is_verified = models.BooleanField(default=False)

    def __str__(self):
        return '{} ({})'.format(self.user, self.role, self.is_verified)

    class Meta:
        db_table = 'profile'
        verbose_name = "Profile"
        verbose_name_plural = "Profiles"

@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)
@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()


class Ideas(models.Model):
    '''
    Ideas. 
    '''
    title = models.CharField(max_length=255, help_text="Enter the title of your idea") #unique=True)
    cover = models.ImageField(upload_to='uploads/%Y/%m/%d/', blank=True, null=True)
    content = models.TextField(help_text="Describe your idea here") #content = HTMLField()
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='author_id')
    create_date = models.DateTimeField(auto_now_add=True)
    edit_date = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(User, blank=True, related_name='likes')
    views = models.ManyToManyField(User, blank=True, related_name='views')    
    IDEA_STATUS = (
        ('c', 'Created'),
        ('p', 'Published'),
        ('a', 'Approved'),
        ('d', 'Declined'),
    )
    status = models.CharField(max_length=1, choices=IDEA_STATUS, blank=True, default='c', help_text='Current status of idea')

    def __str__(self):
        return '"{}" by "{}" now is {}'.format(self.title, self.author, self.status)

    class Meta:
        db_table = 'ideas'
        verbose_name = "Ideas"
        verbose_name_plural = "Ideas"


class Notifications(models.Model):
    '''
    Notifications. 
    '''
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='user')
    moderator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='moderator', blank=True, null=True)
    idea = models.ForeignKey(Ideas, on_delete=models.CASCADE, related_name='idea', blank=True, null=True)
    text = models.CharField(max_length=511, help_text="Enter the title of your idea") #unique=True)
    create_date = models.DateTimeField(auto_now_add=True)
   
    class Meta:
        db_table = 'notifications'
        verbose_name = "Notifications"
        verbose_name_plural = "Notifications"



























