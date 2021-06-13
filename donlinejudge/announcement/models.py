from django.db import models
from accounts.models import User

# Create your models here.

class Announcement(models.Model):
    title = models.CharField(max_length=255, null=True)
    content = models.TextField(null=True)
    creation_time = models.DateTimeField(auto_now_add=True)

    author = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    #== method fields
    def author_id(self):
        if self.author:
            return self.author.id
        return None

    def author_name(self):
        if self.author:
            return self.author.username
        return None


    class Meta:
        db_table = 'announcement'
        ordering = ['-creation_time']
    
    def __str__(self):
        return "Title[{}] Author[{}] Created[{}]".format(self.title, self.author.username, self.creation_time)


