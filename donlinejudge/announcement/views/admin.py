from rest_framework.views import APIView
from rest_framework.response import Response
from announcement.models import Announcement
from announcement.serializers import AnnouncementSerializer
from rest_framework import status


class AnnouncementAdminAPI(APIView):
    def get(self, request):
        """
        get announcement list 
        """
        announcement = Announcement.objects.all().order_by("-creation_time")
        return Response(AnnouncementSerializer(announcement, many=True).data)

    def post(self, request):
        """
        publish announcement
        """
        data = request.data
        announcement = Announcement.objects.create(title=data["title"], content=data["content"], author=data["author"])
        
        announcement.save()
        return Response(AnnouncementSerializer(announcement).data)


class AnnouncementDetailAdminAPI(APIView):

    def put(self, request, id):
        """
        edit announcement
        """
        data = request.data
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return Response("Announcement does not exist.", status=status.HTTP_400_BAD_REQUEST)

        for k, v in data.items():
            setattr(announcement, k, v)
        announcement.save()
        return Response(AnnouncementSerializer(announcement).data)

    def get(self, request, id):
        """
        get one announcement
        """
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return Response("Announcement does not exist.", status=status.HTTP_400_BAD_REQUEST)
        return Response(AnnouncementSerializer(announcement).data)

    def delete(self, request, id):
        try:
            announcement = Announcement.objects.get(id=id)
        except Announcement.DoesNotExist:
            return Response("Announcement does not exist.", status=status.HTTP_400_BAD_REQUEST)
        announcement.delete()
        return Response({"Xoa thanh cong."}, status=status.HTTP_204_NO_CONTENT)
