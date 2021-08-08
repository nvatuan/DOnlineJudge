from rest_framework.views import APIView

from accounts.decorators import admin_required, super_admin_required
from judgeserver.models import JudgeServer
from judgeserver.serializer import JudgeServerSerializer

from utils.make_response import *

from json import dumps

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
            FIELDS = ['hostname', 'socketaddress', 'is_disabled']
            for field in FIELDS:
                if request.data.get(field) == None:
                    error += (f"'{field}' is missing. ")
            if error: raise Exception(error)
            
            data = request.data
            if JudgeServer.objects.filter(socketaddress=data['socketaddress']).exists():
                error += ("Judge server with socket address '{data['socketaddress']}' already exists. ")
            if error: raise Exception(error)

            data['hostname'] = data.get('hostname', '')

            print(data)
            jserver = JudgeServer(
                hostname=data['hostname'],
                socketaddress=data['socketaddress'],
                is_disabled=data.get('is_disabled', False),
                max_pending_tasks=data.get('max_pending_tasks', 8),
            )
            jserver.generate_new_token()
            jserver.save()
            return response_created(JudgeServerSerializer(jserver).data)
        except Exception as e:
            return response_bad_request(str(e))


class JudgeServerDetailAPI(APIView):
    @super_admin_required
    def put(self, request, id):
        """
        Edit Judge Server
        """
        try:
            try:
                jserver = JudgeServer.objects.get(id=id)
            except JudgeServer.DoesNotExist:
                return response_not_found("Judgeserver with id=%s does not exist." % str(id))
            jserver = JudgeServer.objects.get(id=id)

            FIELDS = ['hostname', 'socketaddress', 'is_disabled', 'max_pending_tasks']
            changed = False
            for field in FIELDS:
                if request.data.get(field) != None:
                    setattr(jserver, field, request.data[field])
                    changed=True
            jserver.save()
            
            if changed:
                return response_ok(JudgeServerSerializer(jserver).data)
            else:
                return response_no_content("Request is empty. Nothing is changed.")
        except Exception as e:
            return response_bad_request(e.args)

    @admin_required
    def get(self, request, id):
        """
        Get one Judge Server 
        """
        try:
            try:
                jserver = JudgeServer.objects.get(id=id)
            except JudgeServer.DoesNotExist:
                return response_not_found("Judgeserver with id=%s does not exist." % str(id))

            jserver = JudgeServer.objects.get(id=id)
            return response_ok(JudgeServerSerializer(jserver).data)
        except:
            raise

    @super_admin_required
    def delete(self, request, id):
        try:
            if not JudgeServer.objects.filter(id=id).exists():
                raise f"Judge server with id=`{id}` does not exist."
            jserver = JudgeServer.objects.get(id=id)
            jserver.delete()
            return response_no_content("Delete successful")
        except Exception as e:
            return response_bad_request(str(e))
