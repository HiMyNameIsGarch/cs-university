from typing import Any, List

class Base_UI:
    def __init__(self, opts:dict, header:str = "", header_obj:object = None):
        self.__opts = opts
        self.__header:str = header
        self.__header_obj:object = header_obj

    @property
    def header(self) -> str:
        if self.__header_obj is None:
            return self.__header
        return self.__header + str(self.__header_obj)

    def own_partial(self, func, func_arg) -> None:
        if callable(func_arg) and callable(func):
            func(func_arg())

    def partial_nested(self, func, func2, func_arg) -> None:
        func(func2(func_arg()))

    def print_lst(self, lst:List[Any]) -> None:
        for item in lst:
            print(item)

    def intput(self) -> int:
        return self.get_value_for(int, "Value: ")

    def print_groups(self, groups) -> None:
        i = 1
        for group in groups:
            print(f"Group:{i}")
            self.print_lst(group)
            i+=1

    def set_prop(self, obj:object, prop:str, prop_type:type, prompt:str, method = None) -> None:
        if method is None:
            method = lambda x: x

        self.__set_prop(obj, prop, prop_type,
                      self.get_value_for(prop_type, prompt, method))
        self.__header_obj = str(obj)


    def __set_prop(self, obj:object, prop:str, prop_type:type, value:Any) -> None:
        if value is None:
            return
        if type(value) != prop_type:
            raise TypeError("Invalid type")
        setattr(obj, prop, value)

    def get_value_for(self, prop_type:type, prompt:str, method = None) -> Any:
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


    def wrapper(self, iterator:List[Any], header:str, option, func):
        if not callable(func):
            raise TypeError("Argument func is not callable")

        if option is None:
            option = lambda x: x

        dict = { }
        i = 1
        for p in iterator:
            dict[str(i)] = (option(p), (func(p)))
            i += 1

        bu = Base_UI(dict, header)
        bu.start()


    def __menu(self) -> None:
        print('\033c', end='')
        if self.__header != "":
            print(self.header)
        for key in self.__opts:
            print(key + ".", self.__opts[key][0])

    def start(self) -> None:
        while True:
            try:
                self.__menu()
                key = input("Pick your poison: ")
                if key == "exit":
                    return
                self.__opts[key][1]()
                if key is not "exit":
                    input("")
            except Exception as e:
                input(e)
