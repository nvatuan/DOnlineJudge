from rest_framework.views import APIView
from rest_framework.response import Response
from announcement.models import Announcement
from announcement.serializers import AnnouncementSerializer
from rest_framework import status

from accounts.decorators import admin_required, super_admin_required
from accounts.models import User

from utils.make_response import *


class AnnouncementAPI(APIView):
    serializer_class = AnnouncementSerializer

    def get(self, request):
        """
        Get announcement list 
        """
        if request.user.is_authenticated and request.user.is_admin_role():
            announcement = Announcement.objects.all().order_by("-creation_time")
            return response_ok(AnnouncementSerializer(announcement, many=True).data)
        else:
            announcement = Announcement.objects.filter(is_visible=True)
            return response_ok(AnnouncementSerializer(announcement, many=True).data)

    @super_admin_required
    def post(self, request):
        """
        Publish an announcement
        """
        data = request.data
        serializer = self.serializer_class(data=data)

        if data.get("title", '') == "":
            return response_bad_request({"title": "This field cannot be blank."})
        if data.get("content", '') == "":
            return response_bad_request({"content": "This field cannot be blank."})
        if serializer.is_valid():
            serializer.save()
            return response_ok(serializer.data)
        else:
            return response_bad_request({"is_visible": "This field must be true or false."})


class AnnouncementDetailAPI(APIView):
    # serializer_class = AnnouncementSerializer

    @super_admin_required
    def put(self, request, id):
        """
        Edit announcement
        """
        data = request.data
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return response_bad_request("Announcement does not exist.")

        for k, v in data.items():
            if hasattr(announcement, k):
                setattr(announcement, k, v)
            else:
                return response_bad_request(f"Announcement object does not have attribute '{k}'")
        announcement.save()
        return response_ok(AnnouncementSerializer(announcement).data)

    @admin_required
    def get(self, request, id):
        """
        Get one announcement
        """
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return response_bad_request("Announcement does not exist.")
        return response_ok(AnnouncementSerializer(announcement).data)

    @super_admin_required
    def delete(self, request, id):
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return response_bad_request("Announcement does not exist.")
        announcement.delete()
        return response_no_content("Delete successfully.")
