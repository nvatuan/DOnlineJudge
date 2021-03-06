# Generated by Django 3.1 on 2021-05-21 12:40

from django.db import migrations, models
import utils.file_upload


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0005_auto_20210521_1038'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='profile_pic',
            field=models.ImageField(blank=True, default='avatar/__default__.png', null=True, upload_to=utils.file_upload.FileUploadUtils._wrapper),
        ),
    ]
