"Test case operations"

import re
import shlex
from pathlib import PurePosixPath

from docker.errors import NotFound

from .dockerpy import exec_run, get_bin, put_bin
from .status import Status


def __init__(container, processor, i, ioput, config):
    "Copy binary files to `i` and judge"
    container.exec_run(f"cp -r 0 {i}", workdir=str(processor.workdir))
    exec_run(container, processor.before_judge, f"{processor.workdir}/{i}")

    ### <<< judge using the original Judge function: which only do time measureing and limitting
    #res = judge(container, processor, i, ioput, config)

    ### << new judge_with_timeout
    res = judge_use_timeout(container, processor, i, ioput, config)

    exec_run(container, processor.after_judge, f"{processor.workdir}/{i}")
    return res


def _get_io_file_path(ioro, processor, i, config):
    "Get the absolute path of input or output file"
    return PurePosixPath(
        f"{processor.workdir}/{i}/{config['iofilename'][ioro]}"
        if config["iofilename"].get(ioro)
        else f"{processor.workdir}/{i}.{ioro}"
    )


def judge(container, processor, i, ioput, config):
    "Judge one of the test cases"
    put_bin(container, _get_io_file_path("in", processor, i, config), ioput[0])
    
    command = "bash -c " + shlex.quote(
            "TIMEFORMAT=$'\\n%3lR' && time timeout -sKILL "
            + str(config.get("limit", {}).get("time", 1))
            + " sh -c "
            + shlex.quote(processor.judge)
            + " > "
            + f"{processor.workdir}/{i}.out"
            + (
                " < " + f"{processor.workdir}/{i}.in"
                if not config["iofilename"].get("in")
                else ""
            )
        )
    
    res = container.exec_run(
        command,
        workdir=f"{processor.workdir}/{i}",
        demux=True,
    )

    duration = re.search(
        "\n([0-9]+)m([0-9]+\\.[0-9]{3})s\n$", res.output[1].decode()
    )
    stderr = res.output[1][: duration.span()[0]]
    duration = int(duration.group(1)) * 60 + float(duration.group(2))

    if res.exit_code == 137:
        return Status.TLE, (None, stderr), duration, -1,
    if res.exit_code:
        return Status.RE, (None, stderr), duration, -1,
    try:
        output = get_bin(
            container, _get_io_file_path("out", processor, i, config)
        )
    except NotFound:
        return Status.ONF, (None, stderr), duration, -1
    return (
        Status.AC if output.rstrip() == ioput[1].rstrip() else Status.WA,
        (output, stderr),
        duration, -1,
    )

def judge_use_timeout(container, processor, i, ioput, config):
    "Judge one of the test cases"
    put_bin(container, _get_io_file_path("in", processor, i, config), ioput[0])
    
    command = "/bin/resourceout -t " + str(config.get("limit", {}).get("time", 1)) + " " \
        + "-m " + str(config.get("limit", {}).get("memory", 128000)) + " "          \
        + shlex.quote(
            " sh -c "                                                               \
            + shlex.quote(processor.judge)                                          \
            + " > "                                                                 \
            + f"{processor.workdir}/{i}.out"                                        \
            + (                             
                " < " + f"{processor.workdir}/{i}.in"
                if not config["iofilename"].get("in")
                else ""
            )
        )
    
    ### Retrying
    for retrycounter in range(1, 4):
        #print("Attempt #{}".format(retrycounter))
        
        ### Run the command via docker exec interface
        res = container.exec_run(
            command,
            workdir=f"{processor.workdir}/{i}",
            demux=True,
        )

        ### Extract exitcode and stderr (stdout is via file)
        exitcode = res.exit_code
        try:
            stderr = res.output[1].decode()
        except:
            stderr = ''

        ### Participant program can write to stderr as well, so we need to strip our own stderr output
        pattern = '[A-Z]+\sCPU\s' ## our stderr is eg. 'FINISHED CPU 0.23 MEM 123...' or 'TIME CPU 2.03...' 
        lastocc = re.findall(pattern, stderr)[-1]
        rfindpos = stderr.rfind(lastocc)

        rawusage = stderr[rfindpos:].replace('\n', ' ').split(' ')
        ## rawusage = [<verdict>, 'CPU', <cputime>, 'MEM', <memused>, 'MAXMEM', <max_memused>,...]
        rs_cputime = rawusage[2]
        rs_memused = rawusage[6]

        # Now stderr will only contains output by the participants
        stderr = stderr[:rfindpos]

        ### Preparing results
        """ Format of result
        Result = (
            Verdict, (stdout, stderr), CPU_Time, Mem_Used
        )
        """
        verdict = stdout = None

        ## Preparing Verdict
        verdict = Status.UE
        if rawusage[0] == 'FINISHED':
            if exitcode != 0:
                verdict = Status.RE
            else:
                try:
                    stdout = get_bin(
                        container, _get_io_file_path("out", processor, i, config)
                    )
                    if stdout.rstrip() == ioput[1].rstrip():
                        verdict = Status.AC
                    else:
                        verdict = Status.WA
                except NotFound:
                    verdict = Status.ONF
        elif rawusage[0] == 'TIMEOUT':
            verdict = Status.TLE
        elif rawusage[0] == 'MEM':
            verdict = Status.MLE
        else: ## 'INTERNAL', 'HANGUP', ... it should retry
            continue
        
        ## Return value
        ret = (verdict, (stdout, stderr), rs_cputime, rs_memused)
        return ret
    
    ### After retrying for 3 times
    return (Status.UE, (None, stderr), rs_cputime, rs_memused)
    