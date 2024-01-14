def print_meniu(lst):
    print('\033c', end='')
    print("Your list is: ", lst)
    print("Meniu:")
    print(" 1. Read list")
    print(" 2. Show list")
    print(" 3. Sum of power 2")
    print(" 4. Filter the elem from the list")
    print(" 5. Delete the sequence")
    print(" 0. Exit")
    return input("Opt: ")

def main():
    lst = []
    stop = True
    while stop:
        res = print_meniu(lst)
        stop = res != '0'
        match res:
            case '1':
                lst = read_list()
            case '2':
                for elem in lst: print(elem)
            case _:
                print("Wrong option")

def read_list():
    nlst = []
    num = input("\rNum: ")
    while num != '':
        nlst.append(int(num))
        num = input("\rNum: ")
    return nlst

def is_power_two(num):
    while num % 2 == 0:
        num //= 2
        if num == 1:
            return True
    return False

def filter_power_two(lst:list):
    new_lst = []
    for elem in lst:
        if not is_power_two(elem):
            new_lst.append(elem)
    return new_lst

def sum_of_powers_of_two(lst:list):
    sum = 0
    for elem in lst:
        if is_power_two(elem):
            sum += elem
    return sum


main()
