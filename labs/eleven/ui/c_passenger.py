from functools import partial
from domain.passenger import Passenger
from ui.base_console import Base_UI


class Passenger_UI(Base_UI):
    def __init__(self, passenger:Passenger):
        self.__passenger = passenger
        self.__opts = {
            "1": ("Modify First Name",
                  partial(self.__set_prop, "first_name", str,
                          "Enter new first name: ", lambda value: value != "nigga")),
            "2": ("Modify Last Name",
                  partial(self.__set_prop, "last_name", str,
                          "Enter new last name: ", lambda value: value != "nigga")),
            "3": ("Modify Passport Number",
                  partial(self.__set_prop, "passport", str,
                          "Enter new passport: ", lambda value: value != "my_pass")),
        }
        super().__init__(self.__opts)

    def __set_prop(self, prop:str, prop_type:type, prompt:str, method = None):
        if method is None:
            method = lambda x: x

        self.set_prop(self.__passenger, prop, prop_type,
                      super().get_value_for(prop_type, prompt, method))

    @property
    def passenger(self):
        return self.__passenger
