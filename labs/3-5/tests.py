import funcs as f
import inspect

def should_add():
    tlst = []
    tlst = f.add(tlst, 9)
    assert len(tlst) == 0, "List should not be changed"
    tlst = f.add(tlst, 101)
    assert len(tlst) == 0, "List should not be changed"
    tlst = f.add(tlst, 12)
    assert len(tlst) > 0, "List should have been bigger"

def should_insert():
    tlst = []
    tlst = f.insert(tlst, 0, 99)
    assert len(tlst) == 0, "List should not be changed by the invalid index"
    idx = 2
    tlst = f.insert(tlst, idx, 99)
    assert len(tlst) == idx, "Length of the list should have been 2"
    tlst = f.insert(tlst, 1, 101)
    assert len(tlst) == idx, "List should not be changed by the invalid value"

def should_remove():
    tlst = [23, 34] # Len = 2
    tlst = f.remove(tlst, 0)
    assert len(tlst) == 2, "List should not be changed by invalid index"
    tlst = f.remove(tlst, 1)
    assert len(tlst) == 1, "List should have been modified by the operation"
    tlst = f.remove(tlst, 1000)
    assert len(tlst) == 1, "List should not have been modified by the invalid index"


# Remove interval
def should_remove_interval():
    tlst = [23, 34, 56, 89] # Len = 2
    tlst = f.remove_int(tlst, -1, 2)
    assert len(tlst) == 4, "List should not have been modified by the invalid first index"
    tlst = f.remove_int(tlst, 1, 10)
    assert len(tlst) == 4, "List should not have been modified by the invalid final index"
    tlst = f.remove_int(tlst, 2, 3)
    assert len(tlst) == 2, "The operation should have removed just 2 elements"


# Replace
def should_replace():
    tlst = [23, 34, 56]
    tlst = f.replace(tlst, -1, 67)
    assert len(tlst) == 3, "List should not have been modified by the invalid index"
    nval = 34
    idx = 1
    tlst = f.replace(tlst, idx, nval)
    assert tlst[idx] == nval, "The index value should have been modified"
    tlst = f.replace(tlst, idx, 1000)
    assert tlst[idx] == nval, "The index value should not have been modified by the wrong value"


def should_less():
    tlst = [11, 45, 23]
    nlst = f.less(tlst, 30)
    assert [i for i in nlst if i <= 30] == [11, 23], "Should return the only 2 elements less than 30"
    nlst = f.less(tlst, 9)
    assert [i for i in nlst if i <= 9] == [], "Should return an empty list"
    nlst = f.less(tlst, 100)
    assert [i for i in nlst if i <= 100] == [11, 23, 45], "Should return the entire list sorted"

def should_sort():
    tlst = [11, 13, 12]
    tlst = f.sorted(tlst)
    assert tlst == [11,12,13], "Should return the sorted list"
    tlst = [11,12]
    tlst = f.sorted(tlst)
    assert tlst == tlst, "Should return the list unmodified"
    tlst = []
    tlst = f.sorted(tlst)
    assert tlst == [], "Should return the empty list"

def should_sort_by():
    tlst = [11, 56, 34]
    nlst = f.sorted_by(tlst,101)
    assert nlst == [], "Should return an empty list, value out of bounds"
    nlst = f.sorted_by(tlst, 34)
    assert nlst == [56,34], "Should return 2 elements that follows the rules"
    nlst = f.sorted_by(tlst, 10)
    assert nlst == tlst, "Should return the entire list"


# Avg
def should_avg():
    tlst = [12,13,14]
    avg = f.avg(tlst, 1,2)
    assert avg == 12, "Should return the average value of first 2 terms"
    avg = f.avg(tlst, 2,1)
    assert avg == 0, "Should not return the average of wrong indexes"
    avg = f.avg(tlst, -12, 45)
    assert avg == 0, "Should not return the average of indexes out of bounds"

def should_min():
    tlst = [56, 12, 34]
    min = f.min(tlst, 1, 3)
    assert min == 12, "Should return the minimum value of the list"
    min = f.min(tlst, 3, 1)
    assert min == 0, "Should return default value of 0 as of wrong indexes"
    min = f.min(tlst, -1, 12)
    assert min == 0, "Should return default value of 0 as of wrong indexes"


# Mul
def should_mul():
    tlst = [12, 55, 34, 89]
    mul_lst = f.mul(tlst, 2, 1, 4)
    assert mul_lst == [12, 34], "Should return only the elements that are multiple of 2"
    mul_lst = f.mul(tlst, 2, -1, 10)
    assert mul_lst == [], "Should return empty list as of wrong indexes"
    mul_lst = f.mul(tlst, 13, 1,2)
    assert mul_lst == [], "Should return empty list as there are no multiples of 13 in the list"

# Filter_mul
def should_filter_mul():
    tlst = [12, 55, 34, 89]
    mul_lst = f.filter_mul(tlst, 10)
    assert mul_lst == [], "Should return the only elements mul of 10, which are none"
    mul_lst = f.filter_mul(tlst, 2)
    assert mul_lst == [12, 34], "Should return the only elements mul of 2"
    mul_lst = f.filter_mul(tlst, -1)
    assert mul_lst == [], "Should return empty list as of out of bound value"

# Filter_greater
def should_filter_greater():
    tlst = [12, 55, 34, 89]
    grt_lst = f.filter_greater(tlst, 10)
    assert grt_lst == tlst, "Should return the entire list unmodified"
    grt_lst = f.filter_greater(tlst, 50)
    assert grt_lst == [55, 89], "Should return the only elements greater than 50"
    grt_lst = f.filter_greater(tlst, 101)
    assert grt_lst == [], "Should return empty list as of out of bound value"


# Undo
def should_undo():
    f.vs_list = []
    tlst = [12,14]
    f.append_version(tlst)
    nlst = f.undo()
    assert nlst == tlst, "Should not do the undo operation as it is the only element in the version list"
    f.append_version(f.add(tlst, 12))
    nlst = f.undo()
    assert nlst == tlst, "Should be the first version of the list as it had been performed just one add operation"
    f.append_version(f.add(tlst, 34))
    f.append_version(f.add(tlst, 9))
    nlst = f.undo()
    assert nlst == [12,14,12,34], "Should mimic the last version of the list"


all_functions = inspect.getmembers(__name__, inspect.isfunction)
print(all_functions)
