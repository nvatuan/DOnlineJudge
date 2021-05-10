from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.shortcuts import render

from .forms import CodeForm 
from django_q.tasks import async_task, result 
from .coderunner import send_submission
from .coderunner import Tester

def handle(request):
    rss = {}
    if request.method == 'POST':
        print(request.POST)
        form = CodeForm(request.POST)
        if form.is_valid():
            # process the data in form.cleaned_data as required
            data = form.cleaned_data

            #t_id = async_task(send_submission, data)
            tester = Tester({
                "arr" : [5, 3, 1, 4, 2],
                "id": 69
            })
            t_id = async_task(tester.run)
            rs = result(t_id, 1000)

            src = data["source_code"]
            lang = data["lang"]
            inp = data["inputs"]
            ans = data["answer"]

            ## some thign funky
            rss = {
                "msg" : {
                    "src" : src,
                    "lang" : lang,
                    "inputs" : inp,
                    "answer" : ans,

                    # "verdict" : rs[0][0][0].value,
                    # "output" : rs[0][0][1],
                    # "time" : rs[0][0][2],

                    "rss" : rs,
                }
            }
        else:
            rss = {"msg": "Form is not valid"}
    else:
        rss = {"msg" : "Submit to see rsss"}

    return render(request, 'form.html', rss)
