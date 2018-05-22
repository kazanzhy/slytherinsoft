# Generated by Django 2.0.4 on 2018-05-22 20:23

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='ExtendedUser',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('bio', models.TextField(default='Info about me')),
                ('is_verified', models.BooleanField(default=False)),
            ],
            options={
                'verbose_name': 'Extended User',
                'verbose_name_plural': 'Extended Users',
                'db_table': 'extendeduser',
            },
        ),
        migrations.CreateModel(
            name='Ideas',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=255)),
                ('cover', models.ImageField(blank=True, null=True, upload_to='uploads/%Y/%m/%d/')),
                ('content', models.TextField()),
                ('is_approved', models.BooleanField(default=False)),
                ('create_date', models.DateTimeField(auto_now_add=True)),
                ('edit_date', models.DateTimeField(auto_now=True)),
                ('views', models.PositiveIntegerField(default=0)),
                ('author', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='author_id', to=settings.AUTH_USER_MODEL)),
                ('likes', models.ManyToManyField(blank=True, to=settings.AUTH_USER_MODEL)),
                ('moderator', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='moderator_id', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Ideas',
                'verbose_name_plural': 'Ideas',
                'db_table': 'ideas',
            },
        ),
        migrations.CreateModel(
            name='IdeaStatus',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', models.CharField(max_length=255, unique=True)),
            ],
            options={
                'verbose_name': 'Idea Status',
                'verbose_name_plural': 'Idea Statuses',
                'db_table': 'ideastatus',
            },
        ),
        migrations.CreateModel(
            name='Role',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('role', models.CharField(max_length=255, unique=True)),
            ],
            options={
                'verbose_name': 'Roles',
                'verbose_name_plural': 'Roles',
                'db_table': 'roles',
            },
        ),
        migrations.AddField(
            model_name='ideas',
            name='status',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='status_id', to='testproj.IdeaStatus'),
        ),
        migrations.AddField(
            model_name='extendeduser',
            name='role',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, related_name='role_id', to='testproj.Role'),
        ),
        migrations.AddField(
            model_name='extendeduser',
            name='user',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
