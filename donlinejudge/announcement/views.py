from django.shortcuts import render
from rest_framework import viewsets, permissions
from .serializers import AnnouncementSerializer
from .models import Announcement

# Create your views here.


class AnnouncementViewSet(viewsets.ModelViewSet):
    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]