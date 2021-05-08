from rest_framework.views import APIView
from rest_framework.response import Response
from announcement.models import Announcement
from announcement.serializers import AnnouncementSerializer
from rest_framework import status


class AnnouncementAPI(APIView):
    def get(self, request):
        """
        get announcement list 
        """
        announcement = Announcement.objects.all().order_by("-creation_time")
        return Response(AnnouncementSerializer(announcement, many=True).data)

class AnnouncementDetailAPI(APIView):
    def get(self, request, id):
        """
        get one announcement
        """
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return Response("Announcement does not exist.", status=status.HTTP_400_BAD_REQUEST)
        return Response(AnnouncementSerializer(announcement).data)