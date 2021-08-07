export const VERDICT_TO_CLASSNAME = {
	"Accepted": "accepted",
	"Wrong Answer": "wrong-answer",
	"Runtime Error": "runtime-error",

	"Time Limit Exceeded": "time-limit-exceeded",
	"Memory Limit Exceeded": "memory-limit-exceeded",

	"Compilation Error": "compile-error",

	"New": "new",
	"Judging": "judging",
	"System Error": "system-error",
	"Rejected": "rejected",
	"Rejudging": "rejudging",

	"Waiting": "waiting",
	"Skipped": "skipped",
	"Judged": "judged",
};
export const V2C = (v) => {
	return (VERDICT_TO_CLASSNAME[v] || 'other')
}

export const VERDICT_SHORT = {
	"Accepted": "AC",
	"Wrong Answer": "WA",
	"Runtime Error": "RE",

	"Time Limit Exceeded": "TLE",
	"Memory Limit Exceeded": "MLE",

	"Compilation Error": "CE",

	"New": "NEW",
	"Judging": "JDG",
	"System Error": "SE",
	"Rejected": "RJT",
	"Rejudging": "RJDG",

	"Waiting": "QUEUED",
	"Skipped": "SKIPPD",
	"Judged": "JUDGED",
};
export const VS = (v) => {
	return (VERDICT_SHORT[v] || v)
}
