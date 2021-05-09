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