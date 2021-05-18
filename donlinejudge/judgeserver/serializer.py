from .models import JudgeServer 
from rest_framework import serializers

class JudgeServerSerializer(serializers.ModelSerializer):
    class Meta:
        model = JudgeServer 
        fields = "__all__"
