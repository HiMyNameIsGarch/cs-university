from math import sqrt
from color import Color
from point_repository import PointRepository
from point import Point

pr = PointRepository()

pn = Point(1,2)
pt = Point(1,2)

def should_get_distance():
    p1 = Point(1, 2)
    assert pr.__distance(p1, p1) == 0, "Distance between the same point should be 0"

    p1 = Point(1, 2)
    p2 = Point(4, 6)
    expected_distance = sqrt(((p2.get_coord_x() - p1.get_coord_x()) ** 2) + ((p2.get_coord_y() - p1.get_coord_y()) ** 2))
    assert pr.__distance(p1, p2) == expected_distance, "Distance calculation between different points is incorrect"

    p1 = Point(-1, -3)
    p2 = Point(-4, -6)
    expected_distance = sqrt(((p2.get_coord_x() - p1.get_coord_x()) ** 2) + ((p2.get_coord_y() - p1.get_coord_y()) ** 2))
    assert pr.__distance(p1, p2) == expected_distance, "Distance calculation with negative coordinates is incorrect"

def should_add_point():
    # Test adding a single point and checking if it's in the list
    point = Point(1, 2)
    pr.add_point(point)
    assert point in pr.get_points(), "Point was not successfully added"

    # Test adding a duplicate point and checking if it's in the list only once
    point = Point(1, 2)
    pr.add_point(point)
    pr.add_point(point)
    assert pr.get_points().count(point) == 1, "Duplicate point should not be added"

    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    for point in points:
        pr.add_point(point)
    assert all(p in pr.get_points() for p in points), "Not all points were successfully added"

def should_get_points():
    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    pr.set_points(points)
    assert pr.get_points() == points, "Expected the same list of points as set"

    new_points = [Point(7, 8), Point(9, 10)]
    for point in new_points:
        pr.add_point(point)
    assert pr.get_points() == new_points, "Expected the same list of points as added"

    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    pr.set_points(points)
    returned_points = pr.get_points()
    returned_points.append(Point(7, 8))
    assert pr.get_points() == points, "The returned list should be immutable"


def should_get_point_at():
        points = [Point(1, 2), Point(3, 4), Point(5, 6)]
        pr.set_points(points)
        idx = len(points) + 1
        assert pr.get_point_at(idx) is None, "Expected None for an invalid index"

        points = [Point(1, 2), Point(3, 4), Point(5, 6)]
        pr.set_points(points)
        idx = -2
        assert pr.get_point_at(idx) is None, "Expected None for a negative index"

        points = [Point(1, 2), Point(3, 4), Point(5, 6)]
        pr.set_points(points)
        idx = 0
        assert pr.get_point_at(idx) is None, "Expected None for a zero index"

def should_get_points_of_color():
    color = Color.RED
    point = Point(1, 2, color=color)
    pr.add_point(point)
    assert pr.get_points_of_color(color) == [point], "Expected a list containing the single point of the specified color"

    color = Color.BLUE
    points = [Point(1, 2, color=color), Point(3, 4, color=color), Point(5, 6, color=color)]
    for point in points:
        pr.add_point(point)
    assert pr.get_points_of_color(color) == points, "Expected a list containing all points of the specified color"

    color = Color.GREEN
    points = [Point(1, 2, color=Color.RED), Point(3, 4, color=Color.BLUE)]
    for point in points:
        pr.add_point(point)
    assert pr.get_points_of_color(color) == [], "Expected an empty list as there are no points of the specified color"

def should_get_points_inside_square():
    center_point = Point(1, 1)
    length = 2
    inside_point = Point(2, 0)
    outside_point = Point(4, 4)
    pr.add_point(inside_point)
    pr.add_point(outside_point)
    assert pr.get_points_inside_square(center_point, length) == [inside_point], "Expected a list containing the single point inside the square"

    center_point = Point(1, 1)
    length = 2
    inside_points = [Point(2, 0), Point(0, 2), Point(0, 0)]
    outside_point = Point(4, 4)
    for point in inside_points:
        pr.add_point(point)
    pr.add_point(outside_point)
    assert pr.get_points_inside_square(center_point, length) == inside_points, "Expected a list containing all points inside the square"

    center_point = Point(1, 1)
    length = 2
    outside_points = [Point(4, 4), Point(0, 4), Point(4, 0)]
    for point in outside_points:
        pr.add_point(point)
    assert pr.get_points_inside_square(center_point, length) == [], "Expected an empty list as there are no points inside the square"

def should_get_min_dist():
    # Test getting the minimum distance when the list is empty
    assert pr.get_min_dist() == 100, "Expected default value (100) for an empty list"

    # Test getting the minimum distance when there is only one point in the list
    point = Point(1, 2)
    pr.add_point(point)
    assert pr.get_min_dist() == 100, "Expected default value (100) for a single point in the list"

    points = [Point(1, 2), Point(3, 4), Point(5, 6), Point(7, 8)]
    for point in points:
        pr.add_point(point)

    # Calculate the expected minimum distance
    min_dist = float('inf')
    for i in range(len(points)):
        for j in range(len(points)):
            if i == j:
                continue
            dist = pr.__distance(points[i], points[j])
            if dist < min_dist:
                min_dist = dist
    assert pr.get_min_dist() == min_dist, "Expected the correct minimum distance between points"

def should_update_point_at():
    # Test updating a point at a valid index
    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    pr.set_points(points)
    idx = 2
    new_point = Point(7, 8)
    pr.update_point_at(idx, new_point)
    assert pr.get_points()[idx - 1] == new_point, f"Expected the point at index {idx} to be updated"

    # Test updating a point at an invalid index
    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    pr.set_points(points)
    idx = len(points) + 1
    new_point = Point(7, 8)
    pr.update_point_at(idx, new_point)
    assert pr.get_points() == points, "Expected no update for an invalid index"

    # Test updating a point at a negative index
    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    pr.set_points(points)
    idx = -2
    new_point = Point(7, 8)
    pr.update_point_at(idx, new_point)
    assert pr.get_points() == points, "Expected no update for a negative index"

def should_del_point_at():
    # Test deleting a point at a valid index
    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    pr.set_points(points)
    idx = 2
    pr.del_point_at(idx)
    assert pr.get_points() == [points[0], points[2]], f"Expected the point at index {idx} to be deleted"

    # Test deleting a point at an invalid index
    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    pr.set_points(points)
    idx = len(points) + 1
    pr.del_point_at(idx)
    assert pr.get_points() == points, "Expected no deletion for an invalid index"

    # Test deleting a point at a negative index
    points = [Point(1, 2), Point(3, 4), Point(5, 6)]
    pr.set_points(points)
    idx = -2
    pr.del_point_at(idx)
    assert pr.get_points() == points, "Expected no deletion for a negative index"

def should_del_points_inside_square():
    # Test deleting points inside a square when there is only one point inside
    center_point = Point(1, 1)
    length = 2
    inside_point = Point(2, 0)
    outside_point = Point(4, 4)
    pr.add_point(inside_point)
    pr.add_point(outside_point)
    pr.del_points_inside_square(center_point, length)
    assert pr.get_points() == [outside_point], "Expected the point inside the square to be deleted"

    # Test deleting points inside a square when there are multiple points inside
    center_point = Point(1, 1)
    length = 2
    inside_points = [Point(2, 0), Point(0, 2), Point(0, 0)]
    outside_point = Point(4, 4)
    for point in inside_points:
        pr.add_point(point)
        pr.add_point(outside_point)
        pr.del_points_inside_square(center_point, length)
        assert pr.get_points() == [outside_point], "Expected all points inside the square to be deleted"

        # Test deleting points inside a square when there are no points inside
    center_point = Point(1, 1)
    length = 2
    outside_points = [Point(4, 4), Point(0, 4), Point(4, 0)]
    for point in outside_points:
        pr.add_point(point)
    pr.del_points_inside_square(center_point, length)
    assert pr.get_points() == outside_points, "Expected no deletion as there are no points inside the square"
