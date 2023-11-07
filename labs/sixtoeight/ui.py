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
        opts += "x. Quit\n"
        print(opts)
        return intput("Write the option number: ")

    def __perform_op(self, opt):
        match opt:
            case 1:
                p = Point(intput("Coord X: "), intput("Coord Y: "))
                self.__point_repo.add_point(p)
            case 2:
                pts = self.__point_repo.get_points()
                for e in pts:
                    print(e)
            case 3:
                p = self.__point_repo.get_point_at(intput("Index: "))
                print(p)
            case 4:
                p = self.__point_repo.get_points_of_color(Color(intput("Color: ")))
                for e in p:
                    print(e)
            # case '5':
            # case '6':
            # case '7':
            # case '8':
            # case '9':
            # case '10':
            case _:
                print("Try again :(")

    def start(self):
        valid_res = True
        while valid_res:
            opt = self.__menu()
            self.__perform_op(opt)
            valid_res = opt != self.__EC

