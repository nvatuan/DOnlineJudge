import requests
from json import loads, dumps

URL = "http://127.0.0.1:9999"

def get_tok_from_server(URL, user):
    headers = {"Content-Type": "application/json"}
    data = {"username":user,"password":user,"email":user+"@example.com"}

    ## try register then login 
    print(f"Registering user '{user}'")
    r = requests.post(URL + '/register/', headers=headers, data=dumps(data))
    print(f"Response '{r.status_code}'")

    ## try login
    print(f"Login as user '{user}'")
    r = requests.post(URL + '/login/', headers=headers, data=dumps(data))
    print(f"Response '{r.status_code}'")
    if r.status_code >= 400: return None
    return loads(r.text)["token"]


USER_PREFIX = "benchmarkuser"
USER_COUNT = 1

users = [USER_PREFIX + str(i) for i in range(USER_COUNT)]
users_tok = {}

for u in users:
    users_tok[u] = get_tok_from_server(URL, u)

print(users_tok)

PROBLEM_IDs = []

SOLUTIONS_PY = [
""""a,b=map(int,input().split())
print(a*b)""",]

SOLUTIONS_CPP = [
"""#include<bits/stdc++.h>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    cout << a*b << endl;
}
""",
]

def submit(URL, u, prob_id, source, lang):
    headers = {"Content-Type": "application/json", "Authorization": f"Token {users_tok[u]}"}
    data = {"problem_id": prob_id, "content":source, "language":lang}
    r = requests.post(URL + '/status/', headers=headers, data=dumps(data))
    print("Response",r)
    print("Data",r.text)

submit(URL, users[0], 6, SOLUTIONS_CPP[0], "C++")
