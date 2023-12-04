from numpy._typing import NDArray
from domain.color import Color
import numpy as np

class My_Vector():

    def __init__(self, vt:int=1, color:Color=Color('r')) -> None:
        self.__value:NDArray = np.array([0,0,0])
        self.__name_id = ''
        self.__vtype = self.__get_modulo(vt)
        self.__color = color
        self.__type = { 1 : "o", 2 : "s", 3 : "^" }

    def __eq__(self, __value:object) -> bool:
        if isinstance(__value, My_Vector):
            nv = np.array(__value.get_value())
            return np.array_equal(self.__value, nv)
        return False

    def __get_modulo(self, nv:int):
        if nv == 0:
            return 1
        if nv < 0:
            return -1 * nv
        return nv

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
        self.__value = np.array(new_value)

    def get_name_id(self):
        return self.__name_id

    def set_name_id(self, name_id:str):
        self.__name_id = name_id

    def get_color(self):
        return self.__color

    def set_color(self, color:Color):
        self.__color = color

    def get_type_plot(self) -> str:
        return self.__type.get(self.__vtype, "D")

    def get_type(self) -> int:
        return self.__vtype

    def set_type(self, ntype:int):
        self.__vtype = self.__get_modulo(ntype)

    # Methods
    def add_scalar(self, scalar:int) -> None:
        if scalar < 1:
            return
        self.__value = self.__value + scalar

    def add(self, v:list) -> None:
        if len(v) != len(self.__value):
            return
        na = np.array(v)
        self.__value = self.__value + na

    def subtract(self, v:list) -> None:
        if len(v) != len(self.__value):
            return
        na = np.array(v)
        self.__value = self.__value - na

    def multiplication(self, v:list) -> None:
        if len(v) != len(self.__value):
            return
        na = np.array(v)
        self.__value = self.__value * na

    def sum(self) -> int:
        return np.sum(self.__value)

    def product(self) -> int:
        return int(np.prod(self.__value))

    def avg(self) -> int:
        return self.sum() // len(self.__value)

    def min(self) -> int:
        return np.min(self.__value)

    def max(self) -> int:
        return np.max(self.__value)


