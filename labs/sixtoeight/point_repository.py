import utils
from point import Point
from color import Color
import matplotlib.pyplot as plt
from math import sqrt

class PointRepository:
    def __init__(self) -> None:
        self.__points:list[Point] = [Point(1,2),Point(3,2),Point(2,5),Point(1,4),Point(7,4),Point(3,8),Point(4,1)]

    # Calculates the Euclidean distance between two points in a 2D space.
    # Parameters:
    # - p1 (Point): The first point.
    # - p2 (Point): The second point.
    # Returns:
    # - float: The Euclidean distance between the two points.
    # Note:
    # - The Euclidean distance is calculated as the square root of the sum of squared differences
    #   between the x and y coordinates of the two points.
    def __distance(self, p1:Point, p2:Point):
        return sqrt(((p2.get_coord_x() - p1.get_coord_x()) ** 2) + ((p2.get_coord_y() - p1.get_coord_y()) ** 2))

    # Adds a point to the collection of points in a 2D space.
    # Parameters:
    # - point (Point): The point to be added to the collection.
    # Returns:
    # - None
    # Note:
    # - This function appends the provided point to the existing collection of points.
    def add_point(self, point:Point):
        self.__points.append(point)

    # Optional
    # Adds multiple points to the collection in a 2D space.
    # Parameters:
    # - pts (list[Point]): A list of points to be added to the collection.
    # Returns:
    # - None
    # Note:
    # - This function iterates through the provided list of points and adds each point to the existing collection.
    def set_points(self, pts:list[Point]):
        for p in pts:
            self.add_point(p)

    # Returns the list of points in the collection.
    # Returns:
    # - list[Point]: A list containing all points in the collection.
    def get_points(self):
        return self.__points

    # Returns the point at the specified index.
    # Parameters:
    # - idx (int): The index of the point to retrieve.
    # Returns:
    # - Point or None: The point at the specified index or None if the index is invalid.
    def get_point_at(self, idx):
        if not utils.is_index_valid(self.__points, idx):
            return None
        return self.__points[idx-1]

    # Returns a list of points with the specified color.
    # Parameters:
    # - color (Color): The color to filter points by.
    # Returns:
    # - list[Point]: A list containing points with the specified color.
    def get_points_of_color(self, color:Color) -> list[Point]:
        cpts = []
        for e in self.__points:
            if e.get_color() == color:
                cpts.append(e)
        return cpts

    # Returns a list of points inside a square defined by a center point and length.
    # Parameters:
    # - p (Point): The center point of the square.
    # - len (int): The length of the square sides.
    # Returns:
    # - list[Point]: A list containing points inside the specified square.
    def get_points_inside_square(self, p:Point, len:int) -> list[Point]:
        np = []
        for sp in self.__points:
            if (sp.get_coord_x() <= p.get_coord_x() + len and sp.get_coord_x() >= p.get_coord_x()) and (sp.get_coord_y() >= p.get_coord_y() - len and sp.get_coord_y() <= p.get_coord_y()):
                np.append(sp)
        return np

    # Returns the minimum distance between any two points in the collection.
    # Returns:
    # - float: The minimum distance between any two points.
    def get_min_dist(self) -> float:
        min = 100
        for i in self.__points:
            for j in self.__points:
                if i == j: continue
                d = self.__distance(i, j)
                if d < min:
                    min = d
        return min

    # Updates the point at the specified index with a new point.
    # Parameters:
    # - idx (int): The index of the point to update.
    # - pt (Point): The new point to replace the existing one.
    # Returns:
    # - None
    def update_point_at(self, idx, pt:Point):
        if not utils.is_index_valid(self.__points, idx):
            return None
        self.__points[idx] = pt

    # Deletes the point at the specified index.
    # Parameters:
    # - idx (int): The index of the point to delete.
    # Returns:
    # - None
    def del_point_at(self, idx):
        if not utils.is_index_valid(self.__points, idx):
            return None
        del self.__points[idx]

    # Deletes points inside a square defined by a center point and length.
    # Parameters:
    # - p (Point): The center point of the square.
    # - len (int): The length of the square sides.
    # Returns:
    # - None
    def del_points_inside_square(self, p:Point, len:int):
        idx = 0
        for sp in self.__points:
            if (sp.get_coord_x() <= p.get_coord_x() + len and sp.get_coord_x() >= p.get_coord_x()) and (sp.get_coord_y() >= p.get_coord_y() - len and sp.get_coord_y() <= p.get_coord_y()):
                del self.__points[idx]
            idx = idx + 1

    ## 11 14 17
    # Optional shit
    def get_points_inside_circle(self, x, y, rad:int):
        pts = []
        pt = Point(x, y)
        for p in self.__points:
            if self.__distance(p, pt) <= rad + 1:
                pts.append(p)
        return pts

    def get_points_inside_rect(self, start:int, len:int, width:int):
        np = []
        for sp in self.__points:
            if sp.get_coord_x() <= start + len and sp.get_coord_y() <= start + width:
                np.append(sp)
        return np

    def get_max_dist(self):
        max = -1
        for i in self.__points:
            for j in self.__points:
                d = self.__distance(i, j)
                if d > max:
                    max = d
        return max

    def get_nr_pts_of_color(self, color:Color):
        nr = 0
        for p in self.__points:
            if p.get_color() == color:
                nr += 1
        return nr

    def update_color_of_coords(self, x, y, color:Color):
        for p in self.__points:
            if p.get_coord_x() == x and p.get_coord_y == y:
                p.set_color(color=color)
                return

    def shift_x(self, val):
        for p in self.__points:
            nx = p.get_coord_x() + val
            p.set_coord_x(nx)

    def shift_y(self, val):
        for p in self.__points:
            ny = p.get_coord_y() + val
            p.set_coord_y(ny)

    def del_by_coords(self, x, y):
        i = 0
        for p in self.__points:
            if p.get_coord_x() == x and p.get_coord_y == y:
                self.del_point_at(i)
                return
            i += 1

    def del_points_inside_circle(self, x, y, rad):
        i = 0
        for p in self.__points:
            if self.__distance(p, Point(x, y)) <= rad:
                self.del_point_at(i)
            i += 1

    def del_points_inside_dist(self, x, y, dist):
        i = 0
        for p in self.__points:
            if self.__distance(p, Point(x, y)) == dist:
                self.del_point_at(i)
            i += 1

    def plot_points(self):
        for e in self.__points:
            plt.scatter(e.get_coord_x(), e.get_coord_y())

        plt.show()
