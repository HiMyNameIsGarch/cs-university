from labs.sixtoeight.color import Color

class My_Vector():
    def __get_modulo(self, nv:int):
        if nv == 0:
            return 1
        if nv < 0:
            return -1 * nv
        return nv

    def __init__(self, vt:int, color:Color=Color('r')) -> None:
        self.__value = []
        self.__name_id = ''
        self.__color = color
        self.__asdasdasd = self.__get_modulo(vt)

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

    def set_type(self, ntype:int):
        self.__asdasdasd = self.__get_modulo(ntype)

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


