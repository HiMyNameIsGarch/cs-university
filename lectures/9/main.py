def f(n:int) -> int:
    if n > 0:
        return 3 + f(n-1)
    return 0

def ff(n:int) -> int:
    if n > 9:
        return n % 10 + ff(n // 10)
    else:
        return n






def pascal(n:int) -> list[int]:
    if n == 1:
        return [1]
    else:
        a = pascal(n - 1)
        b = [1]
        for i in range(1, len(a)):
            b.append(a[i] + a[i-1])
        b.append(1)
    return b

def recursive_min(lst:list) -> list:
    if len(lst) == 1:
        if type(lst[0]) == type(list):
            recursive_min(lst[0])
        else:
            return lst[0]
    else:
        if type(lst[0]) == type(list):
            return min(recursive_min(lst[0]), recursive_min(lst[1:]))
        else:
            return min(lst[0], recursive_min(lst[:-1]))

print(recursive_min([2,9,[1,13], 8, 6]))
