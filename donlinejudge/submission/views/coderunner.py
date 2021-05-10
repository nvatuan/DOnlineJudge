
def get_processor_func(lang):
    from .dockerjudge.processor import PyPy, GCC, OpenJDK
    __ = {
        "C" : GCC(GCC.Language.c),
        "C++": GCC(GCC.Language.cpp),
        "Python" : PyPy(),
        "Python3" : PyPy(),
        "Java" : OpenJDK(),
    }
    return __.get(lang, None)

def send_submission_multi_test(src, lang, inputs, answers):
    from .dockerjudge.status import Status
    from .dockerjudge import judge

    # convert to bytes
    inputs = [inp.encode("ascii") for inp in inputs]
    answers = [inp.encode("ascii") for inp in answers]
    src = src.encode("ascii")

    # get processor - Docker container
    processor_func = get_processor_func(lang)

    # Verdict object
    verdict = {}

    if processor_func:
        # Perform run
        jreport = judge(
            processor_func,
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
            _dict["output"] = "" if not jtest[1][0] else jtest[1][0].decode("ascii")
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
    #print(verdict)
    return verdict


if __name__ == "__main__":
    inputs = [b"1 1", b"2 3"]
    answers = [b"2", b"5"]

    from dockerjudge import judge
    from dockerjudge.processor import OpenJDK, GCC, PyPy

    ## Prepare Java Image
    print("Running OpenJDK init...")
    src = b'''import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        int a, b;
        Scanner sc = new Scanner(System.in);
        a = sc.nextInt();
        b = sc.nextInt();
        System.out.println(a+b);
    }
}
'''

    o = judge (
        OpenJDK(),
        src,
        [
            [inputs[0], answers[0]],
            [inputs[1], answers[1]],
        ]
    )
    print(o)

    print("Running GNU G++ init...")
    src = b'''#include <bits/stdc++.h>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    cout << a + b << endl;
}
'''
    o = judge (
        GCC(GCC.Language.cpp),
        src,
        [
            [inputs[0], answers[0]],
            [inputs[1], answers[1]],
        ]
    )
    print(o)

    print("Running GNU GCC init...")
    src = b'''#include <stdio.h>

int main() {
    int a, b;
    scanf("%d%d", &a, &b);
    printf("%d", a+b);
}
'''
    o = judge (
        GCC(GCC.Language.c),
        src,
        [
            [inputs[0], answers[0]],
            [inputs[1], answers[1]],
        ]
    )
    print(o)

    print("Running PyPy init...")
    src = b'''a, b= map(int, input().split())
print(a+b)
'''
    o = judge (
        PyPy(),
        src,
        [
            [inputs[0], answers[0]],
            [inputs[1], answers[1]],
        ]
    )
    print(o)