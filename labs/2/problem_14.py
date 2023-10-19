# Read a natural number N. Print the number of 1s from the binary representation
# of N
# e.g.
# 547 has 4 digits equal to 1 in its binary representation.
n = int(input("num: "))
os = 0
while n != 0:
    if n % 2 != 0:
        os += 1
    n = n // 2
print(os)


