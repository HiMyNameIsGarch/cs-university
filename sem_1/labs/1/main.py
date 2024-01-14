# print("asdasdads")
# a = 4
# b = a//2
# print(b)
# print(type(b))

# a = 2
# b = 3
# print("a =", a, "b =", b)
# print(f"a={a} b={b}")

# var = input("do: ")
# n = int(var)
# print(n * 2)

# first_num = input("Enter your first number: ")
# first_num = int(first_num)
# second_num = input("Enter your second number: ")
# second_num = int(second_num)
#
# sum = first_num + second_num
# print("And the sum of those numbers is:", sum )


# l=[1,2,3,"asd",9,6,67,7]
# # for i in l:
# #     print (i)
#
# l.append("asdasd")
# print(l[-1])
# print(len(l))


# if True:
# elif False:
# else:

# if -1:
#     print("asdasd")
# else:
#     print("asdasdasdasdasd")

# num = 0
# while num < 50:
#     num = input("Give a number: ")
#     num = int(num)
#     if num > 50:
#         print("Congrats")

# for s in "asdasd":
#     print(s)

# max_n = input("Input max number: ")
# max_n = int(max_n)
# sum_of_n = 0
# for i in range(1, max_n):
#     sum_of_n = sum_of_n + i;
#
# sum_of_n = sum_of_n + max_n
# print(sum_of_n)

# pn = input("Give a perfect number: ")
pn = 13
pn = int(pn)
sum = 0
for i in range(1, pn):
    if pn % i == 0:
        sum = sum + i
        if sum == pn:
            print("Is a perfect number")
            break


