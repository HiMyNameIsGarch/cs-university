from domain.plane import Plane
from domain.passenger import Passenger
from ui.generators.g_passenger import Passenger_Generator
from ui.c_passenger import Passenger_UI
from ui.base_console import Base_UI
from functools import partial
from typing import List

class Plane_UI(Base_UI):
    def select_passenger(self, planes:List[Passenger], only_once:bool = False):
        dict = {}
        i = 1
        for p in planes:
            ap = Passenger_UI(p)
            dict[str(i)] = ((p.first_name + " " + p.last_name, ap.start))
            i += 1

        bu = Base_UI(dict, "Select a Passenger:", only_once)
        key = bu.start()
        for i in range(len(planes)):
            if key == str(i + 1):
                return planes[i]

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
            "6": ("Add a passenger", partial(self.own_partial, self.__plane.add_passenger, Passenger_Generator.generate)),
            "7": ("Get passengers", partial(print, self.__plane.passengers)),
            "8": ("Delete a passenger", partial(self.partial_nested_two, self.__plane.remove_passenger, self.select_passenger, self.__plane.passengers, True)),
            "9": ("Select passenger", partial(self.select_passenger, self.__plane.passengers))
        }
        super().__init__(self.__opts, header, self.__plane)
