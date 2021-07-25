from rest_framework.response import Response
from rest_framework import status

## ============= 2xx
def response_ok(message):
    resp = {}
    if isinstance(message, dict):
        if message.get("data") != None:
            resp["data"] = message.get("data", "")
            for k, v in message.items():
                resp[k] = v
            resp["count"] = len(message.get('data', ''))
        else:
            resp["data"] = message
    elif isinstance(message, list):
        resp["data"] = message
        resp["count"] = len(message)
    elif isinstance(message, str):
        resp["data"] = message
    
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

## ============= 5xx
def response_internal_error(message):
    resp = {}
    resp["data"] = message
    resp["error"] = "Something went wrong"
    return Response(resp, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

def response_unavailable(message):
    resp = {}
    resp["data"] = message
    resp["error"] = "Cannot handle the request at the moment"
    return Response(resp, status=status.HTTP_503_SERVICE_UNAVAILABLE)
