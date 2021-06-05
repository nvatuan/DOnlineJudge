from rest_framework.views import APIView
from rest_framework import status

from announcement.models import Announcement
from announcement.serializers import AnnouncementSerializer

from utils.make_response import *
from utils.query_set_rearrange import auto_apply

class AnnouncementAPI(APIView):
    def get(self, request):
        """
        Get announcement list 
        """
        announcement = Announcement.objects.all()
        announcement = auto_apply(announcement, request)
        return response_ok(AnnouncementSerializer(announcement, many=True).data)

class AnnouncementDetailAPI(APIView):
    def get(self, request, id):
        """
        Get one announcement
        """
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return response_bad_request("Announcement does not exist.")
        return response_ok(AnnouncementSerializer(announcement).data)
