import datetime, pytz

def utc_now():
	utc_now = datetime.datetime.utcnow()
	utc_now = utc_now.replace(tzinfo=pytz.utc)
	return utc_now