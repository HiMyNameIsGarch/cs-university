def is_prime(n):
    if n < 2: return False
    if n > 2 and n%2==0:
        return False
    for i in range(3, n, 2):
        if(n%i == 0):
            return False
    return True

def hpn(n):
    h = -1
    for i in range(n, 1, -1):
        if is_prime(i) and i > h:
            h = i

    return h

def sum_digits(n):
    sum = 0
    c = n
    while c > 0:
        sum = sum + c % 10
        c = c // 10
    return sum


def get_even(lst):
    c = 0
    for elem in lst:
        if not elem % 2:
            c += 1
    return c

def get_even2(lst, v):
    c = 0
    for elem in lst:
        if sum_digits(elem) == v:
            c += 1
    return c

def read_list():
    l = []
    s = input("num: ")
    while s != 's':
        l.append(s)
        s = input("num: ")
    return l

l = [1]
def max_num(lst):
    max = -1
    for elem in lst:
        if elem > max:
            max = elem
    return max

def min_num(lst):
    min = lst[0]
    for elem in lst:
        if elem < min:
            min = elem
    return min

def lst_div(n):
    lst = []
    s = 0
    for i in range(1, n):
        if n % i == 0:
            lst.append(i)
            s += i
    return s

def are_friends(n1, n2):
    return lst_div(n1) == n2 and lst_div(n2) == n1

def construct(max):
    lst = []
    n = 1
    while len(lst) < max:
        for _ in range(0,n):
            if len(lst) < max:
                lst.append(n)
        n += 1
    return lst


print(construct(7))
