from domain.color import Color

# Function to interactively receive integer input from the user with optional exit condition.
# Parameters:
#    - txt (str): The prompt text displayed to the user.
#    - ec (str, optional): The exit condition. If the user enters this value, the function returns -1. Default is 'x'.
#
# Returns:
#    - int: The integer entered by the user, or -1 if the exit condition is met.
def intput(txt, ec='x') -> int:
    while True:
        val = input(txt)
        if val == ec:
            return -1
        try:
            return int(val)
        except:
            print('\033[1A' + '\033[K', end='')

# Function to interactively receive integer input from the user with optional exit condition.
# Parameters:
#    - txt (str): The prompt text displayed to the user.
#
# Returns:
#    - Color: The object Color by the user
def colorput(txt) -> Color:
    while True:
        val = input(txt)
        try:
            return Color(val)
        except:
            print('\033[1A' + '\033[K', end='')

# Verify if the indexes are valid for the given list.
# The first index should be greater than 0, and the final index should be within the list's length.
# Params:
#   - lst: the list to be checked
#   - fidx: the first index
#   - tidx: the final index
# Returns: a boolean indicating if the indexes are valid
def is_index_valid(lst, idx):
    return len(lst) >= idx and idx >= 0

