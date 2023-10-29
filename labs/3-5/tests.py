import funcs as f

tlst = []

# Add
tlst = f.add(tlst, 9)
assert len(tlst) == 0, "List should not be changed"
tlst = f.add(tlst, 101)
assert len(tlst) == 0, "List should not be changed"
tlst = f.add(tlst, 12)
assert len(tlst) > 0, "List should have been bigger"

tlst = []

# Insert
tlst = f.insert(tlst, 0, 99)
assert len(tlst) == 0, "List should not be changed by the invalid index"
idx = 2
tlst = f.insert(tlst, idx, 99)
assert len(tlst) == idx, "Length of the list should have been 2"
tlst = f.insert(tlst, 1, 101)
assert len(tlst) == idx, "List should not be changed by the invalid value"

tlst = [23, 34] # Len = 2

# Remove
tlst = f.remove(tlst, 0)
assert len(tlst) == 2, "List should not be changed by invalid index"
tlst = f.remove(tlst, 1)
assert len(tlst) == 1, "List should have been modified by the operation"
tlst = f.remove(tlst, 1000)
assert len(tlst) == 1, "List should not have been modified by the invalid index"

tlst = [23, 34, 56, 89] # Len = 2

# Remove interval
tlst = f.remove_int(tlst, -1, 2)
assert len(tlst) == 4, "List should not have been modified by the invalid first index"
tlst = f.remove_int(tlst, 1, 10)
assert len(tlst) == 4, "List should not have been modified by the invalid final index"
tlst = f.remove_int(tlst, 2, 3)
assert len(tlst) == 2, "The operation should have removed just 2 elements"

tlst = [23, 34, 56]

# Replace
tlst = f.replace(tlst, -1, 67)
assert len(tlst) == 3, "List should not have been modified by the invalid index"
nval = 34
idx = 1
tlst = f.replace(tlst, idx, nval)
assert tlst[idx] == nval, "The index value should have been modified"
tlst = f.replace(tlst, idx, 1000)
assert tlst[idx] == nval, "The index value should not have been modified by the wrong value"

