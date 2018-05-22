from django.db import models
from django.contrib.auth.models import User

from django.template.defaultfilters import slugify


class IdeaStatus(models.Model):
    '''
    Idea statuses. One row - one status (just created, edited, approved, declined)
    '''
    status = models.CharField(unique=True, max_length=255)

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
    role = models.CharField(unique=True, max_length=255)

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
    bio = models.TextField(default='Info about me')
    #link = models.CharField(max_length=255, unique=True)
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
    cover = models.ImageField(upload_to='uploads/%Y/%m/%d/', blank=True, null=True)
    content = models.TextField() #content = HTMLField()
    status = models.ForeignKey(IdeaStatus, on_delete=models.CASCADE, related_name='status_id')
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='author_id')
    moderator = models.ForeignKey(User, on_delete=models.CASCADE, related_name='moderator_id', blank=True, null=True)
    is_approved = models.BooleanField(default=False)
    create_date = models.DateTimeField(auto_now_add=True)
    edit_date = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(User, blank=True)
    views = models.PositiveIntegerField(default=0)    
    slug = models.SlugField(unique=True)

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






