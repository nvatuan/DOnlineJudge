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
    judging_sub_id = models.IntegerField(null=True, default=None)

    last_heartbeat = models.DateTimeField()
    added_time = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "judge_server"
        ordering = ["-is_disabled", "-added_time"]
    
    def __init__(self):
        self.generate_new_token()
    
    def status(self):
        if (timezone.now() - self.last_heartbeat) > 5:
            return JudgeServerStatus.NOT_RESPONSDING
        return JudgeServerStatus.NORMAL
    
    def generate_new_token(self):
        while True:
            self.token = get_random_string(length=32)
            if not JudgeServer.objects.filter(token=self.token).exists(): break
        return self.token
    