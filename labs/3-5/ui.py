import funcs as op
EC = 'x'

def display_menu():
    print("1.  Add score")
    print("2.  Insert score")
    print("3.  Remove score")
    print("4.  Remove scores between 2 indexes")
    print("5.  Replace score")
    print("6.  Get participants with score less than")
    print("7.  Get participants sorted")
    print("8.  Get participants sorted higher than value")
    print("9.  Get average score for participants between 2 indexes")
    print("10. Get minimum score for participants between 2 indexes")
    print("11. Get the score of participants betwee")
    print("12. ")
    print("13. ")
    print("14. ")
    print("x. Quit")

def start(base_list: list):
    display_menu()
    opt = input("Write the option number: ")
    while opt != EC:
        l = perform_op(int(opt), base_list)
        print(l)
        opt = input("Write the option number: ")


def perform_op(opt, lst):
    match opt:
        case 1:
            return op.add_score(lst, int(input("Value for participant: ")))
        case 2:
            return op.remove_score(lst, int(input("Index: ")))
        case 3:
            return op.remove_score(lst, int(input("Index: ")))
        case _:
            print("Try again")
