from rest_framework.authentication import TokenAuthentication, get_authorization_header
from rest_framework.exceptions import AuthenticationFailed, AuthenticationFailed

from donlinejudge.settings import TOKEN_EXPIRE_AFTER_SECONDS
from utils.time import utc_now

from datetime import timedelta

class ExpiringTokenAuthentication(TokenAuthentication):
    def authenticate_credentials(self, key):
        model = self.get_model()
        try:
            token = model.objects.get(key=key)
        except model.DoesNotExist:
            raise AuthenticationFailed('Invalid token')

        if not token.user.is_active:
            raise AuthenticationFailed('User inactive or deleted')

        if token.created < utc_now() - timedelta(seconds=TOKEN_EXPIRE_AFTER_SECONDS):
            raise AuthenticationFailed('Token has expired')

        return token.user, token
