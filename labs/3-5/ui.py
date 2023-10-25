import funcs as op
from copy import deepcopy
EC = 'x'

def menu(lst:list):
    print('\033c', end='')
    print("Your list: ", lst)
    opts = ""
    opts += "1.  Add score\n"
    opts += "2.  Insert score\n"
    opts += "3.  Remove score\n"
    opts += "4.  Remove scores between 2 indexes\n"
    opts += "5.  Replace score\n"
    opts += "6.  get participants with score less than\n"
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

def perform_op(opt, lst):
    match opt:
        case '1':
            new_lst = op.add(lst, int(input("Value for participant: ")))
            input(new_lst)
            return lst
        case '2':
            return op.insert(lst, int(input("Index : ")), int(input("Value: ")))
        case '3':
            return op.remove(lst, int(input("Index: ")))
        case '4':
            return op.remove_int(lst, int(input("Index 1: ")), int(input("Index 2: ")))
        case '5':
            return op.replace(lst, int(input("Index: ")), int(input("Value: ")))
        case '6':
            srt = op.less(lst, int(input("Value: ")))
            input(f"Lower: {srt}")
            return lst
        case '7':
            sorted = op.sorted(lst)
            input(f"Sorted list: {sorted}")
            return lst
        case '8':
            srt = op.sorted_by(lst, int(input("Value: ")))
            input(f"Higher: {srt}")
            return lst
        case '9':
            avg = op.avg(lst, int(input("Index 1: ")), int(input("Index 2: ")))
            input(f"Avg: {avg} ")
            return lst
        case '10':
            avg = op.min(lst, int(input("Index 1: ")), int(input("Index 2: ")))
            input(f"Min Value: {avg} ")
            return lst
        case '11':
            mul = op.mul(lst, int(input("Mul value: ")), int(input("Index 1: ")), int(input("Index 2: ")))
            input(f"Mul: {mul} ")
            return lst
        case '12':
            return op.filter_mul(lst, int(input("Mul Value: ")))
        case '13':
            return op.filter_greater(lst, int(input("Greater Value: ")))
        case '14':
            return op.undo()
        case _:
            print("Try again")
            return lst
