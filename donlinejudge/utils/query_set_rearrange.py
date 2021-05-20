from django.core.exceptions import FieldDoesNotExist
import logging

logging.basicConfig(level=logging.DEBUG)


def filter_then_sort(qset, qdict):
    """
    Apply a `filter()` then a `order_by()`.
    The order of `?filter_by=crit` and `sort_by=crit` are
    handled separatedly. Meaning they will not have effect on eachother.
    """
    return sort(filter(qset, qdict), qdict)

def filter(qset, qdict):
    """
    Filtering QuerySet 
    With url: url?filter_by=criteria1&criteria1=value1&filter_by=criteria2&critera2=value2
    means the QuerySet will be filtered twice, by criteria1 equals value1 first, then criteria2 equals value2 by criteria1 equals value1 first, then criteria2 equals value2
    """
    filter_crits = qdict.getlist("filter_by", [])
    filter_crit_value = {}
    for criteria in filter_crits:
        if qdict.get(criteria) != None:
            try:
                if qset.model._meta.get_field(criteria): # raise FieldDoesNotExist
                    filter_crit_value[criteria] = qdict.get(criteria)
            except FieldDoesNotExist as fdne:
                logging.debug(fdne)
        else:
            logging.debug(f"Filter criteria {criteria} doesn't have a value in the parameters")
    
    logging.debug(f"Filter key-value map: {filter_crit_value}")
    for key, val in filter_crit_value.items():
        try:
            qset = qset.filter(**{key:val})
        except Exception as e:
            logging.debug(e)
    return qset

def sort(qset, qdict):
    """
    Sorting QuerySet
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

    captured_sort_by_keys = qdict.getlist("sort_by", [])
    sort_by_keys = []
    for captured_key in captured_sort_by_keys:
        if len(captured_key) == 0: continue
        # Handle when key in field is valid but having '-' makes get_field() not recognize it
        if captured_key[0] == '-':
            key = captured_key[1:]
        else: 
            key = captured_key

        try:
            if qset.model._meta.get_field(key): # raise FieldDoesNotExist
                sort_by_keys.append(captured_key)
        except FieldDoesNotExist as fe:
            logging.debug(fe)
        except Exception as e:
            logging.debug(e)
        
    logging.debug(f"Sort_by key: {sort_by_keys}")
    return qset.order_by(*sort_by_keys)

