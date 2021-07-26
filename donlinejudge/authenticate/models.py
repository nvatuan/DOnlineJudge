from rest_framework.authentication import TokenAuthentication, get_authorization_header
from rest_framework.exceptions import AuthenticationFailed, AuthenticationFailed
from rest_framework.response import Response
from rest_framework import status

from donlinejudge.settings import TOKEN_EXPIRE_AFTER_SECONDS
from utils.time import utc_now

from datetime import timedelta

def response_unauthorized(message):

class ExpiringTokenAuthentication(TokenAuthentication):
    def authenticate_credentials(self, key):
        print('Token Expire Check')
        model = self.get_model()
        try:
            token = model.objects.get(key=key)
        except model.DoesNotExist:
            resp = {
                "data": "Your Auth token has expired"
                "error": "Permission denied - Token expired"
            }
            return Response(resp, status=status.HTTP_404_NOT_FOUND)

        if not token.user.is_active:
            resp = {
                "data": "This user is currently not active or has been deleted"
                "error": "Permission denied - User inactive"
            }
            return Response(resp, status=status.HTTP_401_UNAUTHORIZED)

        # This is required for the time comparison

        if token.created < utc_now() - timedelta(seconds=TOKEN_EXPIRE_AFTER_SECONDS):
            resp = {
                "data": "Your Auth token has expired"
                "error": "Permission denied - Token expired"
            }
            return Response(resp, status=status.HTTP_401_UNAUTHORIZED)

        return token.user, token