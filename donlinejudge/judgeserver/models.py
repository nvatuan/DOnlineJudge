from django.utils.crypto import get_random_string

from django.db import models
from django.utils import timezone

class JudgeServerStatus():
    NORMAL = "Normal"
    NOT_RESPONSDING = "Not responding"

class JudgeServer(models.Model):
    hostname = models.CharField(max_length=256, null=True) # xxx.xxx.xxx.xxx ## ipv4
    socketaddress = models.CharField(max_length=40)
    token = models.CharField(max_length=32)

    is_disabled = models.BooleanField(default=False)
    pending_tasks = models.IntegerField(default=0)
    max_pending_tasks = models.IntegerField(default=8) # should be increased according to the server number of CPU cores

    last_heartbeat = models.DateTimeField(null=True)
    added_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "judge_server"
        ordering = ["-is_disabled", "-added_time"]

    def __str__(self):
        return f"Hostname=[{self.hostname}], Socket address=[{self.socketaddress}], Token=[{self.token}]"
    
    def status(self):
        if (timezone.now() - self.last_heartbeat).total_seconds() > 10:
            return JudgeServerStatus.NOT_RESPONSDING
        return JudgeServerStatus.NORMAL
    
    def generate_new_token(self):
        while True:
            self.token = get_random_string(length=32)
            if not JudgeServer.objects.filter(token=self.token).exists(): break
        return self.token
    