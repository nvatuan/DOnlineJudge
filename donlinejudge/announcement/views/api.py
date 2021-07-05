from rest_framework.views import APIView
from rest_framework.response import Response
from announcement.models import Announcement
from announcement.serializers import AnnouncementSerializer
from rest_framework import status

from accounts.decorators import admin_required, super_admin_required
from accounts.models import User

from utils.make_response import *
import utils.serialized_data_rearrange as sdr
from utils.pagination import paginate

class AnnouncementAPI(APIView):
    serializer_class = AnnouncementSerializer

    def get(self, request):
        """
        Get announcement list 
        """
        try:
            if request.user.is_authenticated and request.user.is_admin_role():
                announcement = Announcement.objects.all().order_by("-creation_time")
                ann_serialized_data = AnnouncementSerializer(announcement, many=True).data
                ann_serialized_data = sdr.auto_apply(ann_serialized_data, request)
                ann_serialized_data = paginate(ann_serialized_data, request)
                return response_ok(ann_serialized_data)
            else:
                announcement = Announcement.objects.filter(
                    is_visible=True).order_by("-creation_time")
                announcement = AnnouncementSerializer(announcement, many=True).data 
                announcement = paginate(announcement, request)
                return response_ok(announcement)
        except Exception as E:
            #print(E)
            return response_bad_request("Request denied.")

    @super_admin_required
    def post(self, request):
        """
        Publish an announcement
        """
        announcement = request.data
        data = request.data
        serializer = self.serializer_class(
            data=data, context={'request': request})

        if data.get("title", '') == "":
            return response_bad_request({"title": "This field cannot be blank."})
        if data.get("content", '') == "":
            return response_bad_request({"content": "This field cannot be blank."})
        if serializer.is_valid():
            serializer.save()
            return response_ok(serializer.data)
        else:
            return response_bad_request({"entered_data":"Entered data is invalid."})


class AnnouncementDetailAPI(APIView):
    serializer_class = AnnouncementSerializer

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

    def get(self, request, id):
        """
        Get one announcement
        """
        try:
            if request.user.is_authenticated and request.user.is_admin_role():
                announcement = Announcement.objects.get(id=id)
                return response_ok(AnnouncementSerializer(announcement).data)
            else:
                announcement = Announcement.objects.get(id=id, is_visible=True)
                return response_ok(AnnouncementSerializer(announcement).data)
        except Announcement.DoesNotExist:
            return response_not_found("Announcement does not exist.")

    @super_admin_required
    def delete(self, request, id):
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return response_bad_request("Announcement does not exist.")
        announcement.delete()
        return response_no_content("Delete successfully.")
