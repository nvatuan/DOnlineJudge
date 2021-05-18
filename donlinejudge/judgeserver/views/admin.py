from rest_framework.views import APIView

from accounts.decorators import admin_required, super_admin_required
from judgeserver.models import JudgeServer
from judgeserver.serializer import JudgeServerSerializer

from utils.make_response import *

class JudgeServerAPI(APIView):
    @admin_required
    def get(self, request):
        """
        Get a list of Judge Server
        """
        jserver = JudgeServer.objects.all()
        return response_ok(JudgeServerSerializer(jserver, many=True).data)

    @super_admin_required
    def post(self, request):
        """
        Publish a judge server, automatically create an account for it to send heartbeat
        """
        error = ""
        try:
            FIELDS = ['hostname', 'socketaddress']
            for field in FIELDS:
                if request.data.get(field) == None:
                    error += f"'{field}' is missing.\n"
            if error: raise error
            
            data = request.data
            if JudgeServer.objects.filter(socketaddress=data['socketaddress']).exists():
                error = f"Judge server with socket address '{data['socketaddress']}' already exists."
            if error: raise error

            data['hostname'] = data.get('hostname', '')

            jserver = JudgeServer(
                hostname=data['hostname'],
                socketaddress=data['socketaddress']
            )
            jserver.save()
            return response_created(JudgeServerSerializer(jserver))
        except Exception as e:
            return response_bad_request(e)


class JudgeServerDetailAPI(APIView):
    @super_admin_required
    def put(self, request, id):
        """
        Edit Judge Server
        """
        try:
            if not JudgeServer.objects.filter(id=id).exists():
                raise f"Judge server with id=`{id}` does not exist."
            jserver = JudgeServer.objects.get(id=id)

            FIELDS = ['hostname', 'socketaddress', 'is_disabled']
            changed = False
            for field in FIELDS:
                if request.data.get(field) != None:
                    setattr(jserver, field, request.data[field])
                    changed=True
            jserver.save()
            
            if changed:
                return response_ok(JudgeServerSerializer(jserver))
            else:
                return response_no_content("Request is empty. Nothing is changed.")
        except Exception as e:
            return response_bad_reqeust(e)

    @admin_required
    def get(self, request, id):
        """
        Get one Judge Server 
        """
        try:
            if not JudgeServer.objects.filter(id=id).exists():
                raise f"Judge server with id=`{id}` does not exist."
            jserver = JudgeServer.objects.get(id=id)
            return response_ok(JudgeServerSerializer(jserver))
        except Exception as e:
            return response_bad_reqeust(e)

    @super_admin_required
    def delete(self, request, id):
        try:
            if not JudgeServer.objects.filter(id=id).exists():
                raise f"Judge server with id=`{id}` does not exist."
            jserver = JudgeServer.objects.get(id=id)
            return response_no_content("Delete successful")
        except Exception as e:
            return response_bad_reqeust(e)
