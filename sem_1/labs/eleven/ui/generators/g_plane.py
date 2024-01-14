from domain.plane import Plane
from ui.base_console import Base_UI


class Plane_Generator:

    @staticmethod
    def generate() -> Plane:
        bu = Base_UI({}, "Create a plane: ")
        name = bu.get_value_for(str, "Enter name: ") or ""
        number = bu.get_value_for(str, "Enter Number: ") or ""
        company = bu.get_value_for(str, "Enter Airline Company: ") or ""
        num_of_seats = bu.get_value_for(int, "Enter Num of Seats: ") or 1
        destination = bu.get_value_for(str, "Enter Destination: ") or ""

        gen_passenger = Plane(name, number, company, num_of_seats, destination)
        return gen_passenger



