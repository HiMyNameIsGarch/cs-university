from point_repository import PointRepository
from point import Point

pr = PointRepository()

pt = Point(1,2)
pn = Point(1,2)
assert pt == pn
print("nigga")

def should_get_points():
    assert pr.get_points() == [], "Should get empty list as pr is init"
    pr.add_point(pt)
    pr.add_point(pt)
    assert len(pr.get_points()) == 2

def should_add_point():
    pr.add_point(pt)
    assert pr.get_points()[0] == pt, "Should add a point"


def should_get_point_at():
    pass
def should_get_points_of_color():
    pass
def should_get_points_inside_square():
    pass
def should_get_min_dist():
    pass
def should_update_point_at():
    pass
def should_del_point_at():
    pass
def should_del_points_inside_square():
    pass
