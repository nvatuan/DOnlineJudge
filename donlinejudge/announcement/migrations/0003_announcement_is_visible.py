# Generated by Django 3.1 on 2021-06-14 18:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('announcement', '0002_auto_20210521_1940'),
    ]

    operations = [
        migrations.AddField(
            model_name='announcement',
            name='is_visible',
            field=models.BooleanField(default=True, null=True),
        ),
    ]
