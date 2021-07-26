from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication
from accounts.decorators import unauthenticated_user, login_required, super_admin_required
from authenticate.models import ExpiringTokenAuthentication

from donlinejudge.settings import TOKEN_EXPIRE_AFTER_SECONDS

from utils.make_response import *
from utils.time import utc_now

class TestTokenAPI(APIView):
	authentication_classes = [ExpiringTokenAuthentication, SessionAuthentication]
	def get(self, request):
		if request.auth == None:
			return response_bad_request("No Authorization Token is Found.")
		token = request.auth
		ttl=int(TOKEN_EXPIRE_AFTER_SECONDS - (utc_now() - token.created).total_seconds()+0.5)
		if ttl>0:
			return response_ok({
				'reaction':'media/images/reaction/approved.jpg',
				'status': 'alive',
				"TTL": ttl,
			})
		else:
			return response_ok({
				'reaction':'media/images/reaction/disapproved.jpg',
				'status': 'dead',
				"TTL": '-1',
			})