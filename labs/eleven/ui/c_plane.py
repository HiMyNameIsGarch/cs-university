from domain.plane import Plane
from domain.passenger import Passenger
from ui.c_passenger import Passenger_UI
from ui.generators.g_passenger import Passenger_Generator
from ui.base_console import Base_UI
from functools import partial
from typing import List

class Plane_UI(Base_UI):

    def __del_func(self, arg) -> partial[None]:
        return partial(self.__plane.remove_passenger, arg)

    def delete_passenger(self, passengers:List[Passenger]) -> None:
        self.wrapper(passengers, "Select a passenger to delete: ", lambda x: x.full_name, self.__del_func)

    def __select_func(self, arg):
        ap = Passenger_UI(arg)
        return ap.start

    def select_passenger(self, passengers:List[Passenger]):
        self.wrapper(passengers, "Select a passenger:", lambda x: x.full_name, self.__select_func)

    def __init__(self, plane:Plane, header:str = "Current Plane: "):
        self.__plane = plane
        self.__opts = {
            "1": ("Modify Name",
                  partial(self.set_prop, self.__plane, "name", str, "Enter new name: ")),
            "2": ("Modify Number",
                  partial(self.set_prop, self.__plane, "num", str, "Enter new plane number: ")),
            "3": ("Modify Airline Company",
                  partial(self.set_prop, self.__plane, "airline_company", str, "Enter new Airline Company: ")),
            "4": ("Modify Number of Seats: ",
                  partial(self.set_prop, self.__plane, "no_of_seats", int,
                          "Enter new number of seats: ", lambda value: value >=
                          10)),
            "5": ("Modify Destination",
                  partial(self.set_prop, self.__plane, "destination", str,
                          "Enter new Destination: ")),

            "6": ("Add a passenger", partial(self.own_partial,
                                             self.__plane.add_passenger,
                                             Passenger_Generator.generate)),
            "7": ("Get passengers", partial(self.print_lst,
                                            self.__plane.passengers)),
            "8": ("Delete a passenger", partial(self.delete_passenger,
                                                self.__plane.passengers)),
            "9": ("Select passenger", partial(self.select_passenger,
                                              self.__plane.passengers)),
            "10": ("Assig 3: Sort passengers by last name",
                   partial(self.own_partial,
                           self.print_lst,
                           self.__plane.sort_by_last_name)),

            "11": ("Assig 8: Identify passengers from a given plane for which the first name or last name contain a string given as parameter",
                  partial(self.partial_nested,
                          self.print_lst,
                          self.__plane.get_passengers_which_contains,
                          input)),

        }
        super().__init__(self.__opts, header, self.__plane)
