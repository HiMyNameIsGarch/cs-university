from infrastructure.airport_repository import Airport_Repository
from functools import partial
from typing import List
from fakedata import generate_planes
from domain.plane import Plane
from ui.base_console import Base_UI
from ui.c_plane import Plane_UI
from ui.generators.g_plane import Plane_Generator

class UI(Base_UI):

    def __del_func(self, arg):
        return partial(self.__repo.remove_plane, arg)

    def delete_plane(self, planes:List[Plane]):
        self.wrapper(planes, "Select a plane to delete: ", lambda x: x.name, self.__del_func)

    def __select_func(self, arg):
        ap = Plane_UI(arg)
        return ap.start

    def select_plane(self, planes:List[Plane]):
        self.wrapper(planes, "Select a plane:", lambda x: x.name, self.__select_func)

    def __init__(self, args:List[str] = []):
        self.__repo = Airport_Repository()
        if len(args) > 1 and args[1] == "gen":
            self.__repo = Airport_Repository(generate_planes(10, 5, 20))

        self.__opts = {
            "1": ("Select plane", partial(self.select_plane,
                                          self.__repo.planes)),
            "2": ("Get all planes",
                  partial(print, self.__repo.planes)),

            "3": ("Add a plane",
                  partial(self.own_partial,
                          self.__repo.add_plane,
                          Plane_Generator.generate)),

            "4": ("Delete a plane",
                  partial(self.delete_plane, self.__repo.planes)),

            # TODO
            "5": ("Sort the passengers in a plane by last name",
                  partial(print, "todo")),

            "6": ("Sort planes according to the number of passengers",
                  partial(super().own_partial,
                          super().print_lst,
                          self.__repo.sort_by_number_of_passengers)),

            "7": ("Sort planes according to the number of passengers with the first name starting with a given substring",
                  partial(self.partial_nested,
                          self.print_lst,
                          self.__repo.sort_by_no_of_passengers_and_name_starting_with,
                          input)),
            "8": ("Sort planes according to the string obtained by concatenation of the number of passengers in the plane and the destination",
                  partial(self.own_partial,
                          self.print_lst,
                          self.__repo.sort_by_concat_nums_of_passengers_and_destination)),
            "9": ("Identify planes that have passengers with passport numbers starting with the same 3 letters",
                  partial(self.__repo.get_planes_starting_with_the_same_3_letters)),

            # TODO
            "10": ("Identify passengers from a given plane for which the first name or last name contain a string given as parameter",
                  partial(self.print_lst)),

            "11": ("Identify plane/planes where there is a passenger with given name",
                  partial(self.partial_nested,
                          self.print_lst,
                          self.__repo.get_planes_where_is_the_passenger_named,
                          input)),
            # "12": ("K planes", partial(self.__repo.planes, input)),
            # "13": ("K planes", partial(self.__opts, input)),

        }
        super().__init__(self.__opts, "Welcome to Airport Security!")

