from judgeserver.models import JudgeServer 
from rest_framework import serializers

class JudgeServerSerializer(serializers.ModelSerializer):
    status = serializers.ReadOnlyField()

    class Meta:
        model = JudgeServer 
        fields = "__all__"
