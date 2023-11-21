from enum import Enum

class Color(Enum):
    RED=1
    GREEN=2
    BLUE=3
    YELLOW=4
    MAGENTA=5

    def __str__(self):
       return self.name.lower()
