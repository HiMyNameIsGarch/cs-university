from copy import deepcopy

vs_list = []

# This function will append a new list to the versions list (usefull for the undo operation)
# Params: a list to be added in the list
# Return: None, as it just adds a new list to the list
# Dependencies: deepcopy function from copy module
def append_version(lst:list):
    vs_list.append(deepcopy(lst))

# This function will verify if the given value is a valid number or not
# Meaning that it has to be between 10 and 100
# Params: val as an integer
# Returns: a boolean
def is_value_valid(val):
    return val <= 100 and val >= 10

# Verify if the indexes are valid for the given list.
# The first index should be greater than 0, and the final index should be within the list's length.
# Params:
#   - lst: the list to be checked
#   - fidx: the first index
#   - tidx: the final index
# Returns: a boolean indicating if the indexes are valid
def is_index_valid(lst, fidx, tidx):
    return len(lst) >= tidx + 1 and fidx > 0 and fidx <= tidx

# Add the result of a new participant to the array.
# Params:
#   - my_list: the list of participants
#   - value: the value to be added as a new participant
# Returns: the modified list with the new participant added
def add(my_list:list, value):
    if not is_value_valid(value): return my_list
    my_list.append(value)
    append_version(my_list)
    return my_list

# Insert a new value at the specified index in the list.
# Params:
#   - lst: the list of participants
#   - idx: the index where the value should be inserted
#   - val: the value to be inserted
# Returns: the modified list with the new value inserted
def insert(lst:list, idx, val):
    if not is_value_valid(val) or idx < 1: return lst
    if idx + 1 > len(lst):
        for _ in range(len(lst), idx - 1):
            lst.append(0)
    lst.insert(idx - 1, val)
    append_version(lst)
    return lst

# Remove the element at the specified index from the list.
# Params:
#   - lst: the list of participants
#   - idx: the index of the element to be removed
# Returns: the modified list with the element removed
def remove(lst:list, idx): # removes the element at idx
    if not is_index_valid(lst, idx, idx): return lst
    del lst[idx - 1]
    append_version(lst)
    return lst

# Remove elements within the specified index range from the list.
# Params:
#   - lst: the list of participants
#   - fidx: the starting index of removal
#   - tidx: the ending index of removal
# Returns: the modified list with elements removed in the specified range
def remove_int(lst:list, fidx, tidx): # removes elements between the two given idx values
    if not is_index_valid(lst, fidx, tidx): return lst
    del lst[fidx - 1:tidx]
    append_version(lst)
    return lst

# Replace the score at the specified index with a new value.
# Params:
#   - lst: the list of participants
#   - idx: the index where the score should be replaced
#   - nval: the new value to replace the score
# Returns: the modified list with the score replaced
def replace(lst:list, idx, nval): # replaces the score on idx with nval
    if not is_value_valid(nval) or not is_index_valid(lst, idx, idx): return lst
    lst[idx - 1] = nval
    append_version(lst)
    return lst

# Get participants with scores less than or equal to a specified value.
# Params:
#   - lst: the list of participants
#   - val: the value used for filtering
# Returns: a new list of participants meeting the filter criteria
def less(lst:list, val): # get participants with score less than val
    cp = deepcopy(lst)
    cp = sorted([i for i in cp if i <= val])
    return cp

# Get a sorted list of all participants by their score.
# Params:
#   - lst: the list of participants
# Returns: a new list of participants sorted by their scores in ascending order
def sorted(lst:list): # get all participants sorted by their score
    cp = deepcopy(lst)
    cp.sort()
    return cp

# Get the participants with scores higher than or equal to a specified value.
# Params:
#   - lst: the list of participants
#   - val: the threshold value for filtering
# Returns: a new list of participants meeting the filter criteria
def sorted_by(lst:list, val): # get the participants with scores higher than val
    cp = deepcopy(lst)
    cp = [i for i in cp if i >= val]
    return cp

# Calculate the average score of participants within a specified index range.
# Params:
#   - lst: the list of participants
#   - fidx: the starting index for the average calculation
#   - tidx: the ending index for the average calculation
# Returns: the average score of participants within the specified range
#          or 0 if the indices are not valid
def avg(lst:list, fidx, tidx):
    if not is_index_valid(lst, fidx, tidx-1): return 0
    avg = 0
    for elem in lst[fidx-1:tidx]:
        avg += elem
    return avg // (tidx - fidx + 1)

# Find the minimum score of participants within a specified index range.
# Params:
#   - lst: the list of participants
#   - fidx: the starting index for finding the minimum score
#   - tidx: the ending index for finding the minimum score
# Returns: the minimum score of participants within the specified range
#          or 0 if the indices are not valid
def min(lst:list, fidx, tidx):
    if not is_index_valid(lst, fidx, tidx-1): return 0
    nlst = lst[fidx-1:tidx]
    nlst.sort()
    return nlst[0]

# Filter and return a list of participants whose scores are divisible by a specified value
# within a specified index range.
# Params:
#   - lst: the list of participants
#   - mul: the divisor for filtering
#   - fidx: the starting index for filtering
#   - tidx: the ending index for filtering
# Returns: a new list of participants meeting the filter criteria
#          or an empty list if the indices are not valid
def mul(lst:list, mul, fidx, tidx):
    if not is_index_valid(lst, fidx, tidx-1): return []
    nlst = lst[fidx-1:tidx]
    cp = [i for i in nlst if i % mul == 0]
    return cp

# Filter and return a list of participants whose scores are divisible by a specified value.
# Params:
#   - lst: the list of participants
#   - mul: the divisor for filtering
# Returns: a new list of participants meeting the filter criteria
#          or an empty list if mul is less than 0
def filter_mul(lst:list, mul):
    if mul < 0: return []
    nlst = [i for i in lst if i % mul == 0]
    append_version(nlst)
    return nlst

# Filter and return a list of participants whose scores are greater than a specified value.
# Params:
#   - lst: the list of participants
#   - greater: the threshold value for filtering
# Returns: a new list of participants meeting the filter criteria
def filter_greater(lst:list, greater):
    nlst = [i for i in lst if i > greater]
    append_version(nlst)
    return nlst

# Undo the most recent action by reverting to the previous version of the list.
# Returns: the previous version of the list
def undo():
    if len(vs_list) > 1: vs_list.pop()
    return vs_list[-1]
