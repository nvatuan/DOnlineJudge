from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class Announcement(models.Model):
    title = models.CharField(max_length=255, null=True)
    content = models.TextField(null=True)
    creation_time = models.DateTimeField(auto_now_add=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
