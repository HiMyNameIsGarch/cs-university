from domain.plane import Plane
from ui.base_console import Base_UI
from functools import partial

class Plane_UI(Base_UI):
    def __init__(self, plane:Plane, header:str = "Current Plane: "):
        self.__plane = plane
        self.__opts = {
            "1": ("Modify Name",
                  partial(self.set_prop, self.__plane, "name", str, "Enter new first name: ")),
            "2": ("Modify Number",
                  partial(self.set_prop, self.__plane, "num", str, "Enter new plane number: ")),
            "3": ("Modify Airline Company",
                  partial(self.set_prop, self.__plane, "airline_company", str, "Enter new Airline Company: ")),
            "4": ("Modify Number of Seats: ",
                  partial(self.set_prop, self.__plane, "no_of_seats", int,
                          "Enter new Airline Company: ", lambda value: value >=
                          10)),
            "5": ("Modify Destination",
                  partial(self.set_prop, self.__plane, "destination", str,
                          "Enter new Airline Company: ")),
        }
        super().__init__(self.__opts, header, self.__plane)
