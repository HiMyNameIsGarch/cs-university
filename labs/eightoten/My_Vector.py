from Color import Color

class My_Vector():
    def __get_modulo(self, nv:int):
        if nv == 0:
            return 1
        if nv < 0:
            return -1 * nv
        return nv

    def __init__(self, vt:int=1, color:Color=Color('r')) -> None:
        self.__value:list[int] = []
        self.__name_id = ''
        self.__vtype = self.__get_modulo(vt)
        self.__color = color

    def __str__(self) -> str:
        s = ""
        for i in range(len(self.__value)):
            s += str(self.__value[i])
            if i + 1 != len(self.__value):
                s += ", "
        s += " type -> " + str(self.get_type())
        s += " color -> " + str(self.get_color())
        s += " name id -> " + str(self.get_name_id())
        return s

    # Getters and setters
    def get_value(self):
        return self.__value

    def set_value(self, new_value:list):
        self.__value = new_value

    def get_name_id(self):
        return self.__name_id

    def set_name_id(self, name_id:str):
        self.__name_id = name_id

    def get_color(self):
        return self.__color

    def set_color(self, color:Color):
        self.__color = color

    def get_type(self):
        return self.__vtype

    def set_type(self, ntype:int):
        self.__vtype = self.__get_modulo(ntype)

    # Methods
    def add_scalar(self, scalar:int):
        i = 0
        for p in self.__value:
            self.__value[i] = p + scalar
            i += 1

    def add(self, v:list):
        if len(v) != len(self.__value):
            return
        for i in range(len(v)):
            self.__value[i] = self.__value[i] + v[i]

    # OR

    def subtract(self, v:list):
        if len(v) != len(self.__value):
            return
        for i in range(len(v)):
            self.__value[i] = self.__value[i] - v[i]

    def multiplication(self, v:list):
        if len(v) != len(self.__value):
            return
        for i in range(len(v)):
            self.__value[i] = self.__value[i] * v[i]

    def sum(self):
        s = 0
        for n in self.__value:
            s += n
        return s

    def product(self):
        s = 0
        for n in self.__value:
            s *= n
        return s

    def avg(self):
        return self.sum() // len(self.__value)

    def min(self):
        return min(self.__value)

    def max(self):
        return max(self.__value)


