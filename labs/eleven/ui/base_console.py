from typing import Any, List

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

    def set_prop(self, obj:object, prop:str, prop_type:type, value:Any):
        if value is None:
            return
        if type(value) != prop_type:
            raise TypeError("Invalid type")
        setattr(obj, prop, value)

    def get_value_for(self, prop_type:type, prompt:str, method = None):
        if method is None:
            method = lambda x: x

        while True:
            value = input(prompt)
            if value == "exit":
                return None
            try:
                nvalue = prop_type(value)

                if not method(nvalue):
                    raise ValueError("Invalid restriction")

                return nvalue
            except:
                print('\033[1A' + '\033[K', end='')


    def __menu(self):
        print('\033c', end='')
        for key in self.__opts:
            print(key + ".", self.__opts[key][0])

    def start(self):
        while True:
            try:
                self.__menu()
                key = input("Pick your poison: ")
                # key = 't'
                if key == "-1":
                    return
                self.__opts[key][1]()
                input("")
            except Exception as e:
                input(e)
