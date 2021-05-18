from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from judgeserver.views import admin, heartbeat 

urlpatterns = [
    path('judgeserver/', admin.JudgeServerAPI.as_view()),
    path('judgeserver/<int:id>/', admin.JudgeServerDetailAPI.as_view()),
    path('judgeserver_heartbeat/', heartbeat.JudgeServerHeartbeatAPI.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)