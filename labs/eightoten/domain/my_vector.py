from numpy._typing import NDArray
from domain.color import Color
import numpy as np

class My_Vector():

    __TYPE = { 1 : "o", 2 : "s", 3 : "^" }

    def __init__(self, vt:int=1, color:Color=Color('r')) -> None:
        self.__value:NDArray = np.array([0,0,0])
        self.__name_id = 'asd'
        self.__vtype = self.__get_modulo(vt)
        self.__color = color
        self.__type = self.__TYPE.get(1)

    """
    Compare the equality of two My_Vector instances.

    Parameters:
    - other: The object to compare against the current instance for equality.

    Returns:
    - bool: True if the instances are equal, False otherwise.
    """
    def __eq__(self, __value:object) -> bool:
        if isinstance(__value, My_Vector):
            nv = np.array(__value.value)
            return np.array_equal(self.__value, nv)
        return False

    """
    Get the modulo of an integer value.

    Parameters:
    - nv: An integer value.

    Returns:
    - int: The modulo of the input value.
    """
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
        s += ", type -> " + str(self.type)
        s += ", color -> " + str(self.color)
        s += ", name id -> " + self.name_id
        return s

    # Getters and setters
    @property
    def value(self) -> NDArray:
        return self.__value
    @value.setter
    def value(self, value:list) -> None:
        self.__value = np.array(value)

    @property
    def name_id(self) -> str:
        return self.__name_id

    @name_id.setter
    def name_id(self, name:str):
        self.__name_id = name

    @property
    def color(self) -> Color:
        return self.__color

    @color.setter
    def color(self, color:Color):
        self.__color = color

    @property
    def type_color(self) -> str:
        return self.__TYPE.get(self.__vtype, "D")

    @type_color.setter
    def type_color(self, type_color:Color):
        self.type_color = type_color

    @property
    def type(self):
        return self.__type

    @type.setter
    def type(self, type):
        self.__type = type

    # Methods
    """
    Add a scalar value to each element of the vector.

    Parameters:
    - scalar: An integer value to be added. If less than 1, no changes are made.

    Returns: - None
    """
    def add_scalar(self, scalar:int) -> None:
        if scalar < 1:
            return
        self.__value = self.__value + scalar

    """
    Add element-wise values from the input list to the vector.

    Parameters:
    - v: A list of values to be added. Must have the same length as the vector.

    Returns: - None
    """
    def add(self, v:list) -> None:
        if len(v) != len(self.__value):
            return
        na = np.array(v)
        self.__value = self.__value + na

    """
    Element-wise subtraction with another vector.

    Parameters:
    - v: A list representing another vector. Ignored if length differs.

    Returns:
    - None
    """
    def subtract(self, v:list) -> None:
        if len(v) != len(self.__value):
            return
        na = np.array(v)
        self.__value = self.__value - na

    """
    Element-wise multiplication with another vector.

    Parameters:
    - v: A list representing another vector. Ignored if length differs.

    Returns:
    - None
    """
    def multiplication(self, v:list) -> None:
        if len(v) != len(self.__value):
            return
        na = np.array(v)
        self.__value = self.__value * na

    """
    Calculate the sum of vector elements.

    Returns:
    - int: The sum of vector elements.
    """
    def sum(self) -> int:
        return np.sum(self.__value)

    """
    Calculate the product of vector elements.

    Returns:
    - int: The product of vector elements.
    """
    def product(self) -> int:
        return int(np.prod(self.__value))

    """
    Calculate the average of vector elements.

    Returns:
    - int: The average of vector elements (floor division).
    """
    def avg(self) -> int:
        return self.sum() // len(self.__value)

    """
    Find the minimum value in the vector.

    Returns:
    - int: The minimum value in the vector.
    """
    def min(self) -> int:
        return np.min(self.__value)

    """
    Find the maximum value in the vector.

    Returns:
    - int: The maximum value in the vector.
    """
    def max(self) -> int:
        return np.max(self.__value)
