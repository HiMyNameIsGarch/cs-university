from infrastructure.airport_repository import Airport_Repository
from functools import partial
from typing import List
from fakedata import generate_planes
from domain.plane import Plane
from domain.passenger import Passenger
from ui.base_console import Base_UI
from ui.c_passenger import Passenger_UI

class UI(Base_UI):

    def __print_nested(self, lst:List[Plane]):
        for plane in lst:
            print("\n\n", plane.name, "\n")
            for passenger in plane.passengers:
                print(passenger)

    def __init__(self):
        self.__repo = Airport_Repository(generate_planes(10, 5, 20))
        self.pu = Passenger_UI(Passenger("asd", "asd", "asd"))
        self.__opts = {
            "1": ("Add airport",
                  partial(self.__repo.add_plane)),
            "2": ("Get all airports",
                  partial(print, self.__repo.planes)),
            "3": ("Update airport",
                  partial(self.__repo.update_plane)),
            "4": ("Delete airport",
                  partial(self.__repo.delete_plane)),
            "44": ("Get all nested",
                  partial(self.__print_nested, self.__repo.planes)),

            "t": ("test me", self.pu.start),

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
        super().__init__(self.__opts)

