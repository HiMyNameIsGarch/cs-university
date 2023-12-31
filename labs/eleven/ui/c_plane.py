from domain.plane import Plane
from domain.passenger import Passenger
from ui.generators.g_passenger import Passenger_Generator
from ui.base_console import Base_UI
from functools import partial
from typing import List

class Plane_UI(Base_UI):

    def __del_func(self, arg):
        return partial(self.__plane.remove_passenger, arg)

    def delete_passenger(self, passengers:List[Passenger]) -> None:
        self.wrapper(passengers, "Select a passenger to delete: ", lambda x: x.full_name, self.__del_func)

    def __select_func(self, arg):
        ap = Plane_UI(arg)
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
            "7": ("Get passengers", partial(print,
                                            self.__plane.passengers)),
            "8": ("Delete a passenger", partial(self.delete_passenger,
                                                self.__plane.passengers)),
            "9": ("Select passenger", partial(self.select_passenger,
                                              self.__plane.passengers))
        }
        super().__init__(self.__opts, header, self.__plane)
