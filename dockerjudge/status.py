"The collection of judge statuses"

from enum import Enum


class Status(Enum):
    """Enumeration of judge statuses

    ======= =====================
    Name    Value
    ======= =====================
    ``AC``  `Accepted`
    ``WA``  `Wrong Answer`
    ``ONF`` `Output Not Found`
    ``RE``  `Runtime Error`
    ``TLE`` `Time Limit Exceeded`
    ``UE``  `Unknown Error`
    ``CE``  `Compilation Error`
    ======= =====================
    """

    AC = "Accepted"
    WA = "Wrong Answer"
    RE = "Runtime Error"
    CE = "Compilation Error"
    TLE = "Time Limit Exceeded"
    MLE = "Memory Limit Exceeded"
    ONF = "Output Not Found"
    UE = "Unknown Error"
