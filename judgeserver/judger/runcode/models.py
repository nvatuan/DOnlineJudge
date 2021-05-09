from django.db import models
import json

class Code(models.Model):
    source_code = models.TextField()

    inputs = models.CharField(max_length=1024, default="")
    answer = models.CharField(max_length=1024, default="")
    output = models.CharField(max_length=1024, default="")

    verdict = models.CharField(max_length=50, default="New")
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created']
    
