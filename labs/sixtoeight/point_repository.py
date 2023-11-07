import utils
from point import Point
from color import Color


class PointRepository:
    def __init__(self) -> None:
        self.__points:list[Point] = []

    def add_point(self, point:Point):
        self.__points.append(point)

    def get_points(self):
        return self.__points

    def get_point_at(self, idx):
        if not utils.is_index_valid(self.__points, idx):
            return None
        return self.__points[idx-1]

    def get_points_of_color(self, color:Color):
        cpts = []
        for e in self.__points:
            if e.get_color == color:
                cpts.append(e)
        return cpts

    def get_points_inside_square(self):
        return []

    def get_min_dist_of(self):
        return []

    def update_point_at(self, idx, pt:Point):
        if not utils.is_index_valid(self.__points, idx):
            return None
        self.__points[idx] = pt

    def del_point_at(self, idx):
        if not utils.is_index_valid(self.__points, idx):
            return None
        del self.__points[idx]

    def del_points_inside_square(self):
        return []

    def plot_points(self):
        return []

