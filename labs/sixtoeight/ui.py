from point import Point
from point_repository import PointRepository
from utils import intput
from color import Color

class UI:
    __EC='x'

    def __init__(self) -> None:
        self.__point_repo = PointRepository()

    def __menu(self):
        # print('\033c', end='')
        opts = ""
        opts += "1. Add a point to the repository\n"
        opts += "2. Get all points\n"
        opts += "3. Get a point at a given index\n"
        opts += "4. Get all points of a given color\n"
        opts += "5. Get all points that are inside a given square (up-left corner and length given)\n"
        opts += "6. Get the minimum distance between two points\n"
        opts += "7. Update a point at a given inde\n"
        opts += "8. Delete a point by index\n"
        opts += "9. Delete all points that are inside a given square\n"
        opts += "10. Plot all points in a chart (using library matplotlib)\n"

        # Optional
        opts += "11. Get all points that are inside a given circle (center of circle, radius given)\n"
        opts += "12. Get all points that are inside a given rectangle (up-left corner, length and width given)\n"
        opts += "13. Get the maximum distance between two points\n"
        opts += "14. Get the number of points of a given color\n"
        opts += "15. Update the color of a point given its coordinates \n"
        opts += "16. Shift all points on the x axis\n"
        opts += "17. Shift all points on the y axis\n"
        opts += "18. Delete a point by coordinates\n"
        opts += "19. Delete all points that are inside a given circle\n"
        opts += "20. Delete all points within a certain distance from a given point\n"
        opts += "x. Quit\n"
        print(opts)
        return intput("Write the option number: ")

    def __prt_pts(self, pts):
        for p in pts:
            print(p)


    def __req_point(self):
        return Point(intput("Coord X: "), intput("Coord Y: "))

    def __perform_op(self, opt):
        match opt:
            case 1:
                p = self.__req_point()
                self.__point_repo.add_point(p)
            case 2:
                pts = self.__point_repo.get_points()
                self.__prt_pts(pts)
            case 3:
                p = self.__point_repo.get_point_at(intput("Index: "))
                print(p)
            case 4:
                p = self.__point_repo.get_points_of_color(Color(intput("Color: ")))
                self.__prt_pts(p)
            case 5:
                pts = self.__point_repo.get_points_inside_square(self.__req_point(), intput("Length: "))
                self.__prt_pts(pts)
            case 6:
                dts = self.__point_repo.get_min_dist()
                print(dts)
            case 7:
                self.__point_repo.update_point_at(intput("Index: "), self.__req_point())
            case 8:
                self.__point_repo.del_point_at(intput("Index: "))
            case 9:
                self.__point_repo.del_points_inside_square(self.__req_point(), intput("Length: "))
            case 10:
                self.__point_repo.plot_points()
            case 11:
                pts = self.__point_repo.get_points_inside_circle(intput("X: "), intput("Y: "), intput("Radius: "))
                self.__prt_pts(pts)
            case 12:
                pts = self.__point_repo.get_points_inside_rect(intput("Start: "), intput("Length: "), intput("Width: "))
                self.__prt_pts(pts)
            case 13:
                max = self.__point_repo.get_max_dist()
                print("Max distance is:", max)
            case 14:
                nr = self.__point_repo.get_nr_pts_of_color(Color(intput("Color: ")))
                print("Number of points of color is:", nr)
            case 15:
                self.__point_repo.update_color_of_coords(intput("X: "), intput("Y: "), Color(intput("Color: ")))
            case 16:
                self.__point_repo.shift_x(intput("Shift X by: "))
            case 17:
                self.__point_repo.shift_y(intput("Shift Y by: "))
            case 18:
                self.__point_repo.del_by_coords(intput("X: "), intput("Y: "))
            case 19:
                self.__point_repo.del_points_inside_circle(intput("X: "), intput("Y: "), intput("Radius: "))
            case 20:
                self.__point_repo.del_points_inside_dist(intput("X: "), intput("Y: "), intput("Distance: "))
            case _:
                print("Try again :(")

    def start(self):
        valid_res = True
        while valid_res:
            opt = self.__menu()
            self.__perform_op(opt)
            valid_res = opt != self.__EC

