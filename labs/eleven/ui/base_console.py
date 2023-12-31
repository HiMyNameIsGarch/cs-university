from typing import Any, List

class Base_UI:
    def __init__(self, opts:dict, header:str = "", header_obj:object = None):
        self.__opts = opts
        self.__header:str = header
        self.__header_obj:object = header_obj

    @property
    def header(self):
        if self.__header_obj is None:
            return self.__header
        return self.__header + str(self.__header_obj)

    def own_partial(self, func, func_arg):
        if callable(func_arg) and callable(func):
            func(func_arg())

    def partial_nested(self, func, func2, func_arg):
        func(func2(func_arg()))

    def partial_nested_two(self, func, func2, func_arg, func_arg2):
        func(func2(func_arg, func_arg2))

    def partial_two_args(self, bigf, smf1, smf2):
        bigf(smf1(), smf2())

    def print_lst(self, lst:List):
        print(lst)

    def set_prop(self, obj:object, prop:str, prop_type:type, prompt:str, method = None):
        if method is None:
            method = lambda x: x

        self.__set_prop(obj, prop, prop_type,
                      self.get_value_for(prop_type, prompt, method))
        self.__header_obj = str(obj)


    def __set_prop(self, obj:object, prop:str, prop_type:type, value:Any):
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
        if self.__header != "":
            print(self.header)
        for key in self.__opts:
            print(key + ".", self.__opts[key][0])

    def start(self):
        while True:
            try:
                self.__menu()
                key = input("Pick your poison: ")
                # key = 't'
                if key == "exit":
                    return
                self.__opts[key][1]()
                input("")
            except Exception as e:
                input(e)
