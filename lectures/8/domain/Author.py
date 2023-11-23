class Author:
    def __init__(self, fn, ln, a) -> None:
        self.__first_name = fn
        self.__last_name = ln
        self.__a = a

    def __eq__(self, __value: object) -> bool:
        return self.__first_name == __value.get_fn() and self.__last_name == __value.get_ln()

