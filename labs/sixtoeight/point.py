from color import Color

class Point:
    def __init__(self, coord_x:int, coord_y:int, color:Color=Color(1)) -> None:
        self.__coord_x = coord_x
        self.__coord_y = coord_y
        self.__color = color

    def __str__(self) -> str:
        return f"Point ({self.__coord_x}, {self.__coord_y}) of color {self.__color}."

    def set_coord_x(self, coord_x) -> None:
        self.__coord_x = coord_x

    def set_coord_y(self, coord_y):
        self.__coord_y = coord_y

    def set_color(self, color=Color(1)):
        self.__color = color

    def get_coord_x(self) -> int:
        return self.__coord_x

    def get_coord_y(self) -> int:
        return self.__coord_y

    def get_color(self) -> Color:
        return self.__color
