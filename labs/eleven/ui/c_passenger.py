from functools import partial
from domain.passenger import Passenger
from ui.base_console import Base_UI

class Passenger_UI(Base_UI):
    def __init__(self, passenger:Passenger, header:str = "Current Passenger: "):
        self.__passenger = passenger
        self.__opts = {
            "1": ("Modify First Name",
                  partial(self.set_prop, self.__passenger, "first_name", str,
                          "Enter new first name: ")),
            "2": ("Modify Last Name",
                  partial(self.set_prop, self.__passenger,  "last_name", str,
                          "Enter new last name: ")),
            "3": ("Modify Passport Number",
                  partial(self.set_prop, self.__passenger, "passport_number", str,
                          "Enter new passport: ")),
        }
        super().__init__(self.__opts, header, self.__passenger)

    @property
    def passenger(self):
        return self.__passenger
