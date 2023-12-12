from domain.passenger import Passenger

class Plane:
    def __init__(self, nname:str, num:str, airline_co:str, no_of_seats:int, idestination:str, ipassengers:list[Passenger]):
        self.__name:str = nname
        self.__num:str = num
        self.__airline_company:str = airline_co
        self.__no_of_seats:int = no_of_seats
        self.__destination:str = idestination
        self.__passengers:list[Passenger] = ipassengers

        def add_passenger(self, passenger:Passenger) -> None:
            if len(self.__passengers) < self.__no_of_seats:
                raise Exception("No more seats available")
            if passenger in self.__passengers:
                raise Exception("Passenger already on board")

            self.__passengers.append(passenger)
            self.__no_of_seats += 1

        def update_passenger(self, passenger:Passenger) -> None:
            if passenger not in self.__passengers:
                raise Exception("Passenger not on board")

            self.__passengers.remove(passenger)
            self.__passengers.append(passenger)

        def remove_passenger(self, passenger:Passenger) -> None:
            if passenger not in self.__passengers:
                raise Exception("Passenger not on board")

            self.__passengers.remove(passenger)
            self.__no_of_seats -= 1

        def sort_by_last_name(self) -> list[Passenger]:
            return self.__passengers.sort(key=lambda passenger:
                passenger.last_name)

        def sort_by_number_of_passengers(self) -> list[Passenger]:
            return self.__passengers.sort(key=lambda passenger:
                passenger.passport_number)

        def sort_by_names_starting_with(self, letter:str) -> list[Passenger]:
            return self.__passengers.sort(key=lambda passenger:
                passenger.last_name.startswith(letter))

        def sort_by_concat_nums_of_passengers_and_destination(self) -> list[Passenger]:
            return self.__passengers.sort(key=lambda passenger:
                passenger.passport_number + passenger.destination)

        def get_planes_starting_with_the_same_3_letters(self, letter:str) -> list[Passenger]:
            if len(letter) != 3:
                raise Exception("The letter must be 3 characters long")
            return self.__passengers.filter(lambda passenger:
                passenger.last_name.startswith(letter))

        def get_passengers_starting_with(self, letter:str) -> list[Passenger]:
            return self.__passengers.filter(lambda passenger:
                passenger.last_name.startswith(letter) or
                passenger.first_name.startswith(letter))

        def get_planes_where_is_the_passenger_named(self, name:str) -> list[Passenger]:
            return self.__passengers.filter(lambda passenger:
                passenger.last_name == name or
                passenger.first_name == name)


        @property
        def name(self) -> str:
            return self.__last_name

        @name.setter
        def name(self, name:str) -> None:
            self.__name = name

        @property
        def number(self) -> str:
            return self.__num

        @number.setter
        def number(self, num:int) -> None:
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
        def passengers(self) -> list[Passenger]:
            return self.__passengers

        @passengers.setter
        def passengers(self, passengers:list[Passenger]) -> None:
            self.__passengers = passengers
