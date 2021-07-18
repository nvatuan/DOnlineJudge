from django.core.exceptions import FieldDoesNotExist
from django.db.models import Q

import logging

from announcement.models import Announcement
from problem.models import Problem
from accounts.models import User
from submission.models import Submission

logging.basicConfig(level=logging.DEBUG)

def auto_apply(sdata, request):
    """
    Automatically apply a Filter, Sort, Contain to Serialized Data.
    query_params are extracted from request by the function.
    """
    if len(sdata) == 0: return sdata

    from django.http import QueryDict
    qparams = request.query_params

    ## Filter
    filt_qdict = QueryDict('', mutable=True)

    filter_crits = qparams.getlist("filter_by", [])
    for criteria in filter_crits:
        if qparams.get(criteria) != None:
            filt_qdict.update(**{"filter_by" : criteria})
            try:
                if sdata[0].get(criteria) != None: # raise FieldDoesNotExist
                    filt_qdict.update(**{criteria : qparams.get(criteria)})
            except FieldDoesNotExist as fdne:
                logging.debug(fdne)
        else:
            logging.debug(f"Filter criteria {criteria} doesn't have a value in the parameters")
    
    print(filt_qdict)
    print(sdata)
    sdata = filter(sdata, filt_qdict)
    print(sdata)

    ## Sort
    sort_qdict = QueryDict('', mutable=True)

    captured_sort_by_keys = qparams.getlist("sort_by", [])
    for captured_key in captured_sort_by_keys:
        if len(captured_key) == 0: continue
        # Handle when key in field is valid but having '-' makes get_field() not recognize it
        if captured_key[0] == '-':
            key = captured_key[1:]
        else: 
            key = captured_key

        try:
            if sdata[0].get(key) != None: # raise FieldDoesNotExist
                sort_qdict.update(**{"sort_by" : captured_key})
        except FieldDoesNotExist as fe:
            logging.debug(fe)
        except Exception as e:
            logging.debug(e)
    
    sdata = sort(sdata, sort_qdict)

    ## Contains
    words = qparams.getlist("contains", []) 
    logging.debug("Words to look up: {}".format(words))
    for w in words:
        sdata = contains(sdata, w)
    
    ## Done
    return sdata 

def filter(sdata, qdict):
    """
    Filtering Serialized Data (a list of OrderedDict)
    Example url: url?filter_by=criteria1&criteria1=value1&filter_by=criteria2&critera2=value2
    """
    if (len(sdata) == 0): return sdata ## empty 

    filter_crits = qdict.getlist("filter_by", [])
    filter_crit_value = {}
    for criteria in filter_crits:
        if qdict.get(criteria) != None:
            try:
                if sdata[0].get(criteria): # raise FieldDoesNotExist
                    filter_crit_value[criteria] = qdict.get(criteria)
            except FieldDoesNotExist as fdne:
                logging.debug(fdne)
        else:
            logging.debug(f"Filter criteria {criteria} doesn't have a value in the parameters")
    
    logging.debug(f"@Filter: key-value map: {filter_crit_value}")

    newsdata = []
    for data in sdata:
        is_selected = True
        for key, val in filter_crit_value.items():
            try:
                if str(data[key]) != val:
                    is_selected = False # if there is a mismatch, do not add this item in
                    break
            except Exception as e:
                logging.debug(e)
        
        if is_selected:
            newsdata.append(data)

    return newsdata 

def sort(sdata, qdict):
    """
    Sorting on Serialized data 
    With url: `url?sort_by=author&sort_by=id&sort_by=invalid_key`
    means the QuerySet will be sorted accordingly to the order
    stated at the url.

    For example, the queryset will be sorted by author, then by id,
    and so on.

    If the sort_by value is an invalid_key, they it will be ignored.

    By default, the sorting will be in ascending order. To, sort the other way,
    the sort_by value needs a minus character before it.
    For example `url?sort_by=-date` will sort by date descendingly.
    """    
    if len(sdata) == 0: return sdata 

    captured_sort_by_keys = qdict.getlist("sort_by", [])
    if len(captured_sort_by_keys) == 0: return sdata

    print("in Sort, qdict=", qdict)

    sort_crit = []
    sort_negate = []

    for captured_key in captured_sort_by_keys:
        if len(captured_key) == 0: continue

        # Handle the case when key in field is valid but having '-' makes get_field() not recognize it
        if captured_key[0] == '-':
            key = captured_key[1:]
            negate = -1 
        else: 
            key = captured_key
            negate = 1

        try:
            if sdata[0].get(key) != None: # raise FieldDoesNotExist
                sort_crit.append(key)
                sort_negate.append(negate)
        except FieldDoesNotExist as fe:
            logging.debug(fe)
        except Exception as e:
            logging.debug(e)
    
    # Need to construct a custom comparator to use in sorted
    def comparator(lhs, rhs):
        """ lhs and rhs are both OrderedDict
            if lhs should appear before rhs, return -1
            if lhs and rhs are equal return 0
            return 1

            Use sort_crit and sort_negate from above
        """
        assert len(sort_crit) == len(sort_negate)
        n = len(sort_crit)
        for i in range(n):
            sc = sort_crit[i]
            lhsv = lhs[sc] if lhs[sc] != None else ''
            rhsv = rhs[sc] if rhs[sc] != None else ''

            if lhsv < rhsv:
                return -1 * sort_negate[i]
            if lhsv > rhsv:
                return 1 * sort_negate[i]
        return 0

    import functools
    return sorted(sdata, key=functools.cmp_to_key(comparator))

def contains(sdata, lookfor):
    if len(sdata) == 0: return sdata
    logging.debug(lookfor)

    model2lookupfield = {
        Announcement : ("title", "content"),
        Problem : ("title", "statement"),
        User : ("username", "first_name", "last_name", "email"),
        Submission : ("problem_title", "author_name"),
    }

    model_type = None
    LOOK_UP_FIELDS = []

    for mdl, luf in model2lookupfield.items():
        found = True
        for f in luf:
            if f not in sdata[0]:
                found = False
                break
        if found:
            model_type = mdl
            LOOK_UP_FIELDS = luf
            break
    

    newsdata = []
    for data in sdata:
        for field in LOOK_UP_FIELDS:
            val = data[field] if data[field] is not None else ''
            if lookfor in val:
                newsdata.append(data)
                break

    return newsdata
