from django.utils import timezone
from rest_framework.views import APIView

from judgeserver.models import JudgeServer
from judgeserver.serializer import JudgeServerSerializer

from utils.make_response import *

class JudgeServerHeartbeatAPI(APIView):
    def post(self, request):
        try:
            ## TODO enforce sender IP
            if request.data.get('token') == None:
                raise "Token is missing from request data."
            tok = request.data[token]
            if not JudgeServer.objects.filter(token=tok).exists():
                raise "There is no judge server with the token='{tok}'"
            
            jserver = JudgeServer.objects.get(token=tok)
            jserver.last_heartbeat = timezone.now()
            jserver.save()
        except Exception as e:
            return response_bad_request(e)
