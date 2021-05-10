from .dockerjudge.status import Status

def get_processor(lang):
    from .dockerjudge.processor import PyPy, GCC, OpenJDK
    __ = {
        "C" : GCC.Language.c,
        "C++": GCC.Language.cpp,
        "Python" : PyPy,
        "Python3" : PyPy,
        "Java" : OpenJDK
    }
    return __.get(lang, None)

def send_submission_multi_test(src, lang, inputs, answers):
    from .dockerjudge import judge

    # convert to bytes
    inputs = [inp.encode("ascii") for inp in inputs]
    answers = [inp.encode("ascii") for inp in answers]
    src = src.encode("ascii")

    # get processor - Docker container
    processor = get_processor(lang)

    # Verdict object
    verdict = {}

    if processor:
        # Perform run
        jreport = judge(
            processor(),
            src,
            [
                (inputs[i], answers[i]) for i in range(len(inputs))
            ]
        )

        # Get results
        jresult = jreport[0]
        jstderr = jreport[1]

        # Prepping response
        final_verdict = Status.AC
        details = []
        for jtest in jresult:
            _dict = {}
            if final_verdict == Status.AC and jtest[0] != Status.AC:
                final_verdict = jtest[0]
            _dict["test_verdict"] = jtest[0].value
            _dict["output"] = jtest[1][0].decode("ascii")
            _dict["exec_time"] = jtest[2]
            details.append(_dict)

        verdict = {
            "verdict" : final_verdict.value,
            "server_stderr" : jstderr.decode("ascii"),
            "details" : details
        }
    else:
        verdict = {
            "verdict" : "Judged",
            "details" : "Cannot find processor for language %s" % lang
        }
    return verdict