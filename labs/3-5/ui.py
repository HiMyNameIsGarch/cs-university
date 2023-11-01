import funcs as op
from copy import deepcopy
from file_operations import *

def flst(lst:list, s:str):
    for e in lst:
        sep = ", " if e != lst[-1] else ""
        s += str(e) + sep
    return s

EC = 'x' # Exit Character
def menu(lst:list):
    print('\033c', end='')
    print(flst(lst, "Your list: "))
    opts = ""
    opts += "1.  Add score\n"
    opts += "2.  Insert score\n"
    opts += "3.  Remove score\n"
    opts += "4.  Remove scores between 2 indexes\n"
    opts += "5.  Replace score\n"
    opts += "6.  Get participants with score less than\n"
    opts += "7.  Get participants sorted\n"
    opts += "8.  Get participants sorted higher than value\n"
    opts += "9.  Get average score for participants between 2 indexes\n"
    opts += "10. Get minimum score for participants between 2 indexes\n"
    opts += "11. Get the score of participants between two given index values, which are multiples of value\n"
    opts += "12. Keep only participants with scores multiple of value, removing the others\n"
    opts += "13. Keep only participants with scores higher than value, -''-\n"
    opts += "14. Undo the last operation modified by the array\n"
    opts += "x. Quit\n"
    print(opts)
    return input("Write the option number: ")

def start(base_list: list):
    op.append_version(base_list)
    valid_res = True
    while valid_res:
        opt = menu(base_list)
        valid_res = opt != EC
        base_list = deepcopy(perform_op(opt, base_list))
        write_lst(base_list)

def intput(txt):
    while True:
        val = input(txt)
        try:
            return int(val)
        except:
            print('\033[1A' + '\033[K', end='')


def perform_op(opt, lst):
    match opt:
        case '1':
            new_lst = op.add(lst, intput("Value for participant: "))
            input(flst(new_lst, "New list: "))
            return lst
        case '2':
            return op.insert(lst, intput("Index : "), intput("Value: "))
        case '3':
            return op.remove(lst, intput("Index: "))
        case '4':
            return op.remove_int(lst, intput("Index 1: "), intput("Index 2: "))
        case '5':
            return op.replace(lst, intput("Index: "), intput("Value: "))
        case '6':
            srt = op.less(lst, intput("Value: "))
            input(flst(srt, "Lower: "))
            return lst
        case '7':
            sorted = op.sorted(lst)
            input(flst(sorted,"Sorted list" ))
            return lst
        case '8':
            srt = op.sorted_by(lst, intput("Value: "))
            input(flst(srt, "Higher: "))
            return lst
        case '9':
            avg = op.avg(lst, intput("Index 1: "), intput("Index 2: "))
            input(f"Avg: {avg} ")
            return lst
        case '10':
            avg = op.min(lst, intput("Index 1: "), intput("Index 2: "))
            input(f"Min Value: {avg} ")
            return lst
        case '11':
            mul = op.mul(lst, intput("Mul value: "), intput("Index 1: "), intput("Index 2: "))
            input(flst(mul, "Mul: "))
            return lst
        case '12':
            return op.filter_mul(lst, intput("Mul Value: "))
        case '13':
            return op.filter_greater(lst, intput("Greater Value: "))
        case '14':
            return op.undo()
        case _:
            print("Try again :(")
            return lst
