from .models import Announcement
from rest_framework import serializers

class AnnouncementSerializer(serializers.ModelSerializer):
    author_id = serializers.ReadOnlyField()
    author_name = serializers.ReadOnlyField()

    class Meta:
        model = Announcement
        exclude = ('author',)


class CreateAnnouncementSerializer(serializers.Serializer):
    title = serializers.CharField(max_length=64)
    content = serializers.CharField(max_length=1024 * 1024 * 8)
    author = serializers.CharField()


class EditAnnouncementSerializer(serializers.Serializer):
    title = serializers.CharField(max_length=64)
    content = serializers.CharField(max_length=1024 * 1024 * 8)
    author = serializers.CharField()
