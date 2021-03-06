# Generated by Django 3.2.4 on 2021-07-19 09:00

from django.db import migrations, models
import utils.file_upload


class Migration(migrations.Migration):

    dependencies = [
        ('problem', '0005_alter_problem_test_zip'),
    ]

    operations = [
        migrations.RenameField(
            model_name='problem',
            old_name='visible',
            new_name='is_visible',
        ),
        migrations.AlterField(
            model_name='problem',
            name='test_zip',
            field=models.FileField(blank=True, default=None, null=True, upload_to=utils.file_upload.FileUploadUtils._wrapper),
        ),
    ]
