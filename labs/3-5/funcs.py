from copy import deepcopy

vs_list = []

def append_version(lst:list):
    vs_list.append(deepcopy(lst))

def is_value_valid(val):
    return val <= 100 and val >= 10

def is_index_valid(lst, fidx, tidx):
    return len(lst) >= tidx + 1 and fidx > 0 and fidx <= tidx

# 1. Add the result of a new participant to the array
def add(my_list:list, value):
    if not is_value_valid(value): return my_list
    my_list.append(value)
    append_version(my_list)
    return my_list

def insert(lst:list, idx, val):
    if not is_value_valid(val) or idx < 1: return lst
    if idx + 1 > len(lst):
        for _ in range(len(lst), idx - 1):
            lst.append(0)
    lst.insert(idx - 1, val)
    append_version(lst)
    return lst

# 2. Modify the scores in the array (as a result of appeals)
def remove(lst:list, idx): # removes the element at idx
    if not is_index_valid(lst, idx, idx): return lst
    del lst[idx - 1]
    append_version(lst)
    return lst

def remove_int(lst:list, fidx, tidx): # removes elements between the two given idx values
    if not is_index_valid(lst, fidx, tidx): return lst
    del lst[fidx - 1:tidx]
    append_version(lst)
    return lst

def replace(lst:list, idx, nval): # replaces the score on idx with nval
    if not is_value_valid(nval) or not is_index_valid(lst, idx, idx): return lst
    lst[idx - 1] = nval
    append_version(lst)
    return lst

# 3 Get the participants with scores having some properties
def less(lst:list, val): # get participants with score less than val
    cp = deepcopy(lst)
    cp = sorted([i for i in cp if i <= val])
    return cp

def sorted(lst:list): # get all participants sorted by their score
    cp = deepcopy(lst)
    cp.sort()
    return cp

def sorted_by(lst:list, val): # get the participants with scores higher than val
    cp = deepcopy(lst)
    cp = [i for i in cp if i >= val]
    return cp

# 4 Obtain different characteristics of participants
def avg(lst:list, fidx, tidx):
    if not is_index_valid(lst, fidx, tidx): return 0
    avg = 0
    for elem in lst[fidx-1:tidx-1]:
        avg += elem
    return avg // (tidx - fidx + 1)


def min(lst:list, fidx, tidx):
    if not is_index_valid(lst, fidx, tidx): return 0
    nlst = lst[fidx-1:tidx-1]
    nlst.sort()
    return nlst[0]

def mul(lst:list, mul, fidx, tidx):
    if not is_index_valid(lst, fidx, tidx): return 0
    nlst = lst[fidx-1:tidx-1]
    cp = [i for i in nlst if i % mul == 0]
    return cp

# 5 Filter Values
def filter_mul(lst:list, mul):
    nlst = [i for i in lst if i % mul == 0]
    append_version(nlst)
    return nlst

def filter_greater(lst:list, greater):
    nlst = [i for i in lst if i > greater]
    append_version(nlst)
    return nlst

# 6 Undo
def undo():
    if len(vs_list) > 1: vs_list.pop()
    return vs_list[-1]
