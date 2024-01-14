from domain.passenger import Passenger
from ui.base_console import Base_UI

class Passenger_Generator:

    @staticmethod
    def generate() -> Passenger:
        bu = Base_UI({}, "Create a passenger: ")
        fname = bu.get_value_for(str, "Enter first name: ") or ""
        lname = bu.get_value_for(str, "Enter last name: ") or ""
        passport = bu.get_value_for(str, "Enter passport number: ") or ""

        gen_passenger = Passenger(fname, lname, passport)
        return gen_passenger



