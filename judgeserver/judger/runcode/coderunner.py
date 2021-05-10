from django_q.tasks import Task

class Tester:
    def __init__(self, data):
        self.data = data
        self.arr = data["arr"]
        self.id = data["id"]
    
    def run(self):
        self.arr.sort()
        return {
            "id": self.id,
            "arr": self.arr
        }
    
    def post(task):
        self.id = 96

    

def send_submission(data):
    from .dockerjudge import judge
    from .dockerjudge.processor import PyPy

    inp = data["inputs"].encode("ascii")
    ans = data["answer"].encode("ascii")
    src = data["source_code"].encode("ascii")

    o = judge(
        PyPy(),
        src,
        [
            (inp, ans),
        ],
    )
    return o