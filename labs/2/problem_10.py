# Read integers numbers until number 0 is read. Print the number of pairs 𝒏𝟏 and
# 𝒏𝟐 of numbers read consecutively with the property that the number of digits 5
# from 𝒏𝟏 is strictly higher than the number of digits 5 from 𝒏𝟐.

# e.g. If the numbers read are 182, 457,341, 497, 5597, 1335, 15, 38, 5, 0 than the result is 3 (as the
# pairs 457-341, 5597-1335, 15-38 satisfy the required property)


# This function counts the number of digits of the constant 'c' predefined as 5
# Params: num (type:int)
# Returns: the number of digits of 5
def nod(num):
    c = 5
    i = 0
    while num != 0:
        if num % 10 == c:
            i+=1
        num = num // 10
    return i

l = []
fs = int(input("num: "))
while fs != 0:
    sn = int(input("num: "))
    if nod(fs) > nod(sn) and sn != 0:
        l.append(f"{fs, sn}")
    fs = sn
print(len(l))
