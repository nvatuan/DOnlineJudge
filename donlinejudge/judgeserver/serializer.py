from judgeserver.models import JudgeServer 
from rest_framework import serializers

class JudgeServerSerializer(serializers.ModelSerializer):
    status = serializers.ReadOnlyField()

    class Meta:
        model = JudgeServer 
        fields = ("hostname", "socketaddress", 
            "token", "is_disabled", "judging_sub_id",
            "last_heartbeat", "status", "added_time")
