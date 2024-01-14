# Problem 2
# y = int(input("year: "))
# d = int(input("days: "))
# m = d // 30
# d = d % 30
# if m != 0: m+=1
# if m < 10: m = "0" + str(m)
# print(f"{d}.{m}.{y}")

# Problem 6 !!
y = int(input("year : "))
m = int(input("month: "))
d = int(input("days : "))
cy = 2023
cm = 10
cd = 2

# Problem 10 ! check zero final stopping point
# def nod(num):
#     i = 0
#     while num != 0:
#         if num % 10 == 5:
#             i+=1
#         num = num // 10
#     return i
#
# l = []
# fs = int(input("num: "))
# while fs != 0:
#     sn = int(input("num: "))
#     if nod(fs) > nod(sn):
#         l.append(f"{fs, sn}")
#     fs = sn
# print(l)






# Problem 14
# n = int(input("num: "))
# os = 0
# while n != 0:
#     if n % 2 != 0:
#         os += 1
#     n = n // 2
# print(os)

# Problem 18
# fn = input("first number: ")
# sn = input("second number: ")
# cml = []
# for i in fn:
#     for j in sn:
#         if i == j and not i in cml:
#             cml.append(i)
# print(len(cml))
# print(cml)
