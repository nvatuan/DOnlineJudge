# Generated by Django 3.1 on 2021-05-19 13:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('judgeserver', '0002_auto_20210519_1009'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='judgeserver',
            name='judging_sub_id',
        ),
        migrations.AddField(
            model_name='judgeserver',
            name='max_pending_tasks',
            field=models.IntegerField(default=8),
        ),
        migrations.AddField(
            model_name='judgeserver',
            name='pending_tasks',
            field=models.IntegerField(default=0),
        ),
    ]
