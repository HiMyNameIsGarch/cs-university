
# 1. Add the result of a new participant to the array
def add(my_list:list, value):
    my_list.append(value)
    return my_list

def insert(sl:list, idx, val):
    if idx + 1 > len(sl):
        for _ in range(len(sl), idx):
            sl.append(0)
    sl.insert(idx, val)
    return sl

# 2. Modify the scores in the array (as a result of appeals)
def remove(sl:list, idx): # removes the element at idx
    if len(sl) < idx + 1:
        return sl
    sl.pop(idx)
    return sl

def remove_int(sl:list, fidx, tidx): # removes elements between the two given idx values
    for i in range(fidx, tidx):
        sl.pop(i)
    return sl

def replace(sl:list, idx, nval): # replaces the score on idx with nval
    sl[idx] = nval
    return sl

# 3. Get the participants with scores having some properties
def less_score(sl:list, val): # get participants with score less than val
    return "a"

def sorted_score(sl:list): # get all participants sorted by their score
    return "a"

def sorted_score_by(sl:list, val): # get the participants with scores higher than val
    return "a"
