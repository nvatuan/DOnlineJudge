from django_q.tasks import async_task, result

# create the task
async_task('math.copysign', 2, -2)

# or with a reference
import math.copysign

task_id = async_task(copysign, 2, -2)

# get the result
task_result = result(task_id)

# result returns None if the task has not been executed yet
# you can wait for it
task_result = result(task_id, 200)

# but in most cases you will want to use a hook:

async_task('math.modf', 2.5, hook='.print_result')

# hooks.py
def print_result(task):
    print(task.result)