from django.urls import path
from .views import AnnouncementViewSet
from rest_framework import routers


router = routers.DefaultRouter()
router.register('announcement', AnnouncementViewSet, 'announcement')

urlpatterns = router.urls