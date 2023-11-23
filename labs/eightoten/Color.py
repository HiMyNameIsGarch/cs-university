from enum import Enum

class Color(Enum):
    RED='r'
    GREEN='g'
    BLUE='b'
    YELLOW='y'
    MAGENTA='m'

    def __str__(self):
       return self.name.lower()

