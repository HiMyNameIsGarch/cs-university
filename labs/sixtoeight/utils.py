def intput( txt):
    while True:
        val = input(txt)
        try:
            return int(val)
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

