from django.db import models
from django.contrib.auth.models import User

from django.template.defaultfilters import slugify


class ExtendedUser(models.Model):
    '''
    Users. Extends of standard model
    '''
    user = models.OneToOneField(User, on_delete=models.SET_NULL, null = True) # Standart User model
    firstname = models.CharField(max_length=255, blank=True, help_text="Enter your firstname")
    lastname = models.CharField(max_length=255, blank=True, help_text="Enter your lastname")
    city = models.CharField(max_length=255, blank=True, help_text="Enter city where you live")
    bio = models.TextField(blank=True, help_text="Enter some info about you")
    #link = models.CharField(max_length=255, unique=True)
    is_moderator = models.BooleanField(default=False)
    is_verified = models.BooleanField(default=False)
    USER_ROLE = (
        ('a', 'architect'),
        ('m', 'moderator'),
        ('u', 'User'),
        ('b', 'Banned'),
    )
    role = models.CharField(max_length=1, choices=USER_ROLE, blank=True, default='u', help_text='User role')

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
    title = models.CharField(max_length=255, help_text="Enter the title of your idea") #unique=True)
    cover = models.ImageField(upload_to='uploads/%Y/%m/%d/', blank=True, null=True)
    content = models.TextField(help_text="Describe your idea here") #content = HTMLField()
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='author_id')
    moderator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='moderator_id', blank=True, null=True)
    is_approved = models.BooleanField(default=False)
    create_date = models.DateTimeField(auto_now_add=True)
    edit_date = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(User, blank=True)
    views = models.PositiveIntegerField(default=0)    
    slug = models.SlugField(unique=True)
    IDEA_STATUS = (
        ('c', 'Just created'),
        ('e', 'Edited'),
        ('a', 'Approved'),
        ('d', 'Declined'),
    )
    status = models.CharField(max_length=1, choices=IDEA_STATUS, blank=True, default='c', help_text='Current status of idea')

    def __str__(self):
        return '"{}" by "{}" now is {}'.format(self.title, self.author, self.status)

    @models.permalink
    def get_absolute_url(self):
        return ('blog_post_detail', (),
                {
                    'slug': self.slug,
                })

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title)
        super(Ideas, self).save(*args, **kwargs)

    class Meta:
        db_table = 'ideas'
        verbose_name = "Ideas"
        verbose_name_plural = "Ideas"






