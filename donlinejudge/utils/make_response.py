from rest_framework.response import Response
from rest_framework import status

## ============= 2xx
def response_ok(message):
    resp = {}
    resp["data"] = message
    if isinstance(message, list):
        resp["total"] = len(message)
    resp["error"] = "none"
    return Response(resp, status=status.HTTP_200_OK)

def response_created(message):
    resp = {}
    resp["data"] = message
    resp["error"] = "none"
    return Response(resp, status=status.HTTP_201_CREATED)

def response_no_content(message):
    resp = {}
    resp["data"] = message
    resp["error"] = "none"
    return Response(resp, status=status.HTTP_204_NO_CONTENT)

## ============= 4xx
def response_unauthorized(message):
    resp = {}
    resp["data"] = message
    resp["error"] = "Permission denied - Unauthorized"
    return Response(resp, status=status.HTTP_401_UNAUTHORIZED)

def response_forbidden(message):
    resp = {}
    resp["data"] = message
    resp["error"] = "Permission denied - Forbidden"
    return Response(resp, status=status.HTTP_403_FORBIDDEN)

def response_not_found(message):
    resp = {}
    resp["data"] = message
    resp["error"] = "Required resource cannot be found"
    return Response(resp, status=status.HTTP_404_NOT_FOUND)

def response_bad_request(message):
    resp = {}
    resp["data"] = message
    resp["error"] = "Failed to handle request"
    return Response(resp, status=status.HTTP_400_BAD_REQUEST)
