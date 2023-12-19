def my_search(lst:list, condition):
    nlst = []
    for elem in lst:
        if condition(elem):
            nlst.append(elem)
    return nlst

def get_armstrong_numbers(lst:list):
    nlst = []
    for elem in lst:
        if is_armstrong(elem):
            nlst.append(elem)

def is_armstrong(num):
    sum = 0
    temp = num
    while temp > 0:
        digit = temp % 10
        sum += digit ** 3
        temp //= 10
    if num == sum:
        print(num, "is an Armstrong number")
    else:
        print(num, "is not an Armstrong number")

def quicksort(lst:list):
    if len(lst) <= 1:
        return lst
    pivot = lst.pop()
    left = []
    right = []
    for elem in lst:
        if elem < pivot:
            left.append(elem)
        else:
            right.append(elem)
    return quicksort(left) + [pivot] + quicksort(right)


def relation(x,y):
    return x > y

def my_sort(lst, f):
    for i in range(len(lst)):
        for j in range(i+1, len(lst)):
            if f(lst[i], lst[j]):
                lst[i], lst[j] = lst[j], lst[i]
    return lst
