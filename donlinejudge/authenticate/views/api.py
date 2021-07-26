from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authentication import TokenAuthentication, SessionAuthentication
from accounts.decorators import unauthenticated_user, login_required, super_admin_required
from authenticate.models import ExpiringTokenAuthentication

from donlinejudge.settings import TOKEN_EXPIRE_AFTER_SECONDS

from utils.make_response import *
from utils.time import utc_now

class TestTokenAPI(APIView):
	authentication_classes = [TokenAuthentication, SessionAuthentication]
	def get(self, request):
		if request.auth == None:
			return response_bad_request("No Authorization Token is Found in Headers")
		model = self.get_model()

		try:
			token = model.objects.get(key=key)
		except model.DoesNotExist:
			return response_bad_request("Invalid Token")

		if not token.user.is_active:
			return response_bad_request('User is Inactive or Deleted')

		token = request.auth
		ttl=int(TOKEN_EXPIRE_AFTER_SECONDS - (utc_now() - token.created).total_seconds()+0.5)
		if ttl>0:
			return response_accepted({
				'status': 'alive',
				'TTL': ttl,
				#'reaction':'media/images/reaction/approved.jpg',
			})
		else:
			return response_unauthorized({
				'status': 'dead',
				'TTL': '-1',
				#'reaction':'media/images/reaction/disapproved.jpg',
			})