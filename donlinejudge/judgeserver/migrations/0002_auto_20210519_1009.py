# Generated by Django 3.1 on 2021-05-19 03:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('judgeserver', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='judgeserver',
            name='last_heartbeat',
            field=models.DateTimeField(null=True),
        ),
    ]
