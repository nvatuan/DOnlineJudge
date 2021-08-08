import requests
import logging as lg
from json import dumps, loads
lg.basicConfig(level=lg.DEBUG)

URL = "http://127.0.0.1:9999/"
ADMIN_ACCOUNT = {
    "username": "admin",
    "password": "admin"
}
headers = {
    "Content-Type": "application/json"
}
r = requests.post(URL+"login/", headers=headers, data=dumps(ADMIN_ACCOUNT))
if not r.ok:
    lg.debug("Failed to login")
    lg.debug(f"Response {r}")
    lg.debug(f"Text {r.text}")
    exit(0)

ADMIN_TOK = loads(r.text)["token"]
lg.debug(f"Admin token is {ADMIN_TOK}")

class Test:
    url = ""
    pass

class TestSortFilterAccountApi(Test):
    url = URL + "admin/account/"
    def __init__(self):
        raise NotImplementedError

class TestSortFilterProblemApi(Test):
    FILT = "filter_by="
    SORT = "sort_by="
    def __init__(self):
        self.url = URL + "problem/"
        raise NotImplementedError
    
    def filter_ok(self):
        postfix = "?filter_by="
        raise NotImplementedError


