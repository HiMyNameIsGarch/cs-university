from typing import List

class Base_UI:
    def __init__(self, opts:dict):
        self.__opts = opts

    def own_partial(self, func, func_arg):
        if callable(func_arg) and callable(func):
            func(func_arg())

    def partial_nested(self, func, func2, func_arg):
        func(func2(func_arg()))

    def partial_two_args(self, bigf, smf1, smf2):
        bigf(smf1(), smf2())

    def print_lst(self, lst:List):
        print(lst)

    def __menu(self):
        print('\033c', end='')
        for key in self.__opts:
            print(key + ".", self.__opts[key][0])

    def start(self):
        while True:
            try:
                self.__menu()
                key = input("Pick your poison: ")
                if key == "-1":
                    return
                self.__opts[key][1]()
                input("")
            except Exception as e:
                input(e)
