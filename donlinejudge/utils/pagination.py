def get_page_size():
	from donlinejudge.settings import PAGINATION_PAGE_SIZE
	return PAGINATION_PAGE_SIZE

def paginate(listobj, request):
	if len(listobj) == 0:
                return listobj
	page_params = request.query_params.getlist("page", [])
	if len(page_params) == 0:
		return get_page(listobj, 1)
	try:
		return get_page(listobj, int(page_params[0]))
	except ValueError:
		raise ValueError(f"Page param {page_params[0]} is not a valid parameter for ?page")
	except IndexError:
		raise

def get_page(listobj, page):
	"""
		Return a dictionary with kwargs as follow:
		- data: contains the list of paginated data
		- total: total count of original data (before paginated)
		- maxpage: the index of the final page
	"""
	if page <= 0:
		raise IndexError(f"Page number {page} should be positive")

	PAGESIZE = get_page_size()
	total = len(listobj)

	max_pages = (total + PAGESIZE - 1) // PAGESIZE
	if page > max_pages:
		raise IndexError(f"Page number {page} exceeds max pages")
	
	return {
		'data': listobj[(page-1)*PAGESIZE:min(page*PAGESIZE, total)],
		'total': total,
		'maxpage': max_pages
	}

