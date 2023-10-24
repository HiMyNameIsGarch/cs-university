from copy import deepcopy

# 1. Add the result of a new participant to the array
def add(my_list:list, value):
    my_list.append(value)
    return my_list

def insert(lst:list, idx, val):
    if idx + 1 > len(lst):
        for _ in range(len(lst), idx - 1):
            lst.append(0)
    lst.insert(idx - 1, val)
    return lst

# 2. Modify the scores in the array (as a result of appeals)
def remove(lst:list, idx): # removes the element at idx
    if len(lst) < idx + 1:
        return lst
    del lst[idx - 1]
    return lst

def remove_int(lst:list, fidx, tidx): # removes elements between the two given idx values
    del lst[fidx - 1:tidx]
    return lst

def replace(lst:list, idx, nval): # replaces the score on idx with nval
    lst[idx - 1] = nval
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
    avg = 0
    for elem in lst[fidx-1:tidx]:
        avg += elem
    return avg // (tidx - fidx + 1)


def min(lst:list, fidx, tidx):
    nlst = lst[fidx-1:tidx]
    nlst.sort()
    return nlst[0]

def mul(lst:list, mul, fidx, tidx):
    nlst = lst[fidx-1:tidx]
    cp = [i for i in nlst if i % mul == 0]
    return cp

# 5 Filter Values
def filter_mul(lst:list, mul):
    return [i for i in lst if i % mul == 0]

def filter_greater(lst:list, greater):
    return [i for i in lst if i > greater]

# 6 Undo
def undo():
    return []
