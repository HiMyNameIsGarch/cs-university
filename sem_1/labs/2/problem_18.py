# Print the number of common digits of two numbers, as well as the digits.
# e.g.
# Input
#     first number: 21348
#     second number: 14513
# Output
#     3
#     1, 3, 4
#

fn = input("first number: ")
sn = input("second number: ")
cml = []
for i in fn:
    for j in sn:
        if i == j and not i in cml:
            cml.append(i)
print(len(cml))
print(cml)

