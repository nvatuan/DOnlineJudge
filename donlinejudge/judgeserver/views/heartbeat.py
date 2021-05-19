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
                raise Exception("Token is missing from request data.")
            tok = request.data['token']

            try:
                jserver = JudgeServer.objects.get(token=tok)
            except JudgeServer.DoesNotExist:
                return response_not_found(f"Judge server with token={tok} does not exist.")
            
            jserver = JudgeServer.objects.get(token=tok)
            jserver.last_heartbeat = timezone.now()
            jserver.save()
            return response_no_content("Heartbeat received.")
        except Exception as e:
            return response_bad_request(str(e))
