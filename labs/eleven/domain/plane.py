import uuid
from typing import List, Optional
from domain.passenger import Passenger
from domain.sorting import Sorting

class Plane:
    def __init__(self, nname:str, num:str, airline_co:str, no_of_seats:int,
                 idestination:str, ipassengers:Optional[List[Passenger]] =
                 None):
        self.__id:uuid.UUID = uuid.uuid4()
        self.__name:str = nname
        self.__num:str = num
        self.__airline_company:str = airline_co
        self.__no_of_seats:int = no_of_seats
        self.__destination:str = idestination
        if ipassengers is None:
            ipassengers = []
        self.__passengers:List[Passenger] = ipassengers
        self.__no_of_passengers:int = len(ipassengers)

    # Make the contains function search based on the __id property
    def __contains__(self, key):
        return key == self.__id

    def __str__(self) -> str:
        return f"{self.name} -- {self.number} -- {self.airline_company} -- {self.no_of_passengers} -- {self.destination}\n"

    __repr__ = __str__

    def add_passenger(self, passenger:Passenger) -> None:
        if len(self.__passengers) < self.__no_of_seats:
            raise Exception("No more seats available")
        if passenger in self.__passengers:
            raise Exception("Passenger already on board")

        self.__passengers.append(passenger)
        self.__no_of_passengers += 1

    def remove_passenger(self, passenger:Passenger) -> None:
        if passenger not in self.__passengers:
            raise Exception("Passenger not on board")

        self.__passengers.remove(passenger)
        self.__no_of_passengers -= 1

    # 3
    def sort_by_last_name(self) -> List[Passenger]:
        return Sorting.sort(self.passengers, lambda passenger: passenger.last_name)

    # 8
    def get_passengers_starting_with(self, letter:str) -> list[Passenger]:
        return Sorting.filter(self.__passengers, lambda passenger:
            passenger.last_name.startswith(letter) or
            passenger.first_name.startswith(letter))

    # 10 - TODO
    def form_groups_of_passengers_same_plane_diff_last_name(self, k:int) -> List[List[Passenger]]:
        return Sorting.groups_of(k, self.__passengers, lambda passenger:
            passenger.last_name)

    @property
    def id(self) -> uuid.UUID:
        return self.__id

    @property
    def passengers_and_destination(self) -> str:
        return f"{self.destination.lower()} {self.no_of_passengers}"

    @property
    def no_of_passengers(self) -> int:
        return self.__no_of_passengers

    @property
    def name(self) -> str:
        return self.__name

    @name.setter
    def name(self, name:str) -> None:
        self.__name = name

    @property
    def number(self) -> str:
        return self.__num

    @number.setter
    def number(self, num:str) -> None:
        self.__num = num

    @property
    def airline_company(self) -> str:
        return self.__airline_company

    @airline_company.setter
    def airline_company(self, airline:str) -> None:
        self.__airline_company = airline

    @property
    def seats(self) -> int:
        return self.__seats

    @seats.setter
    def seats(self, seats:int) -> None:
        self.__seats = seats

    @property
    def destination(self) -> str:
        return self.__destination

    @destination.setter
    def destination(self, destination:str) -> None:
        self.__destination = destination

    @property
    def passengers(self) -> List[Passenger]:
        return self.__passengers

    @passengers.setter
    def passengers(self, passengers:List[Passenger]) -> None:
        self.__passengers = passengers
