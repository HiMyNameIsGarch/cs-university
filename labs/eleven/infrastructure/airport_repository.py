from domain.plane import Plane
from domain.sorting import Sorting
from typing import List, Optional
from functools import partial

class Airport_Repository:
    def __init__(self, planes:Optional[List[Plane]]=None) -> None:
        if planes is None:
            planes = []
        self.__planes:List[Plane] = planes
        self.__no_of_planes:int = len(planes)

    @property
    def planes(self) -> List[Plane]:
        return self.__planes

    @property
    def no_of_planes(self) -> int:
        return self.__no_of_planes

    # 1. Add a new plane to the airport
    # Parameters: plane:Plane the plane to be added
    # Return: None
    # Exceptions: Plane already exists when adding a plane with the same number as an existing one
    def add_plane(self, plane:Plane) -> None:
        if plane in self.__planes:
            raise Exception("Plane already exists")

        self.__planes.append(plane)
        self.__no_of_planes += 1

    # 2. Remove a plane from the airport
    # Parameters: plane:Plane the plane to be removed
    # Return: None
    # Exceptions: Plane not found when removing a plane that does not exist
    def remove_plane(self, plane:Plane) -> None:
        if plane not in self.__planes:
            raise Exception("Plane not found")

        self.__planes.remove(plane)
        self.__no_of_planes -= 1

    # 4. Sort the planes by the number of passengers
    # Parameters: None
    # Return: List[Plane] the sorted list of planes
    # Exceptions: None
    def sort_by_number_of_passengers(self) -> List[Plane]:
        return Sorting.sort(self.planes, lambda plane:
            plane.no_of_passengers)

    # 5. Sort the planes by the number of passengers and the name of the passengers starting with a given letter
    # Parameters: letter:str the letter to be searched for
    # Return: List[Plane] the sorted list of planes
    # Exceptions: None
    def sort_by_no_of_passengers_and_name_starting_with(self, letter:str) -> List[Plane]:
        return Sorting.sort([plane for plane in self.__planes if
            Sorting.filter(plane.passengers, lambda passenger:
                passenger.full_name.startswith(letter))], lambda plane:
                    plane.no_of_passengers)
    # 6. Sort the planes by the concatenation of the number of passengers and the destination
    # Parameters: None
    # Return: List[Plane] the sorted list of planes
    # Exceptions: None
    def sort_by_concat_nums_of_passengers_and_destination(self) -> List[Plane]:
        return Sorting.sort(self.__planes, lambda plane:
            plane.passengers_and_destination)

    # 7. Sort the planes by the number of passengers and the number of passengers with passports starting with a given letter
    # Parameters: letter:str the letter to be searched for
    # Return: List[Plane] the sorted list of planes
    # Exceptions: None
    def get_planes_starting_with_the_same_3_letters(self) -> List[Plane]:
        return [plane for plane in self.__planes if
            Sorting.filter(plane.passengers, lambda passenger:
                passenger.passport_number.startswith(passenger.passport_number[0:3]))]

    # 9. Get the planes where a given passenger is on board
    # Parameters: name:str the name of the passenger
    # Return: List[Plane] the list of planes
    # Exceptions: None
    def get_planes_where_is_the_passenger_named(self, name:str) -> List[Plane]:
        return [plane for plane in self.__planes if
            Sorting.filter(plane.passengers, lambda passenger:
                passenger.full_name == name)]

    # 11. Form groups of planes with the same destination and different airline companies
    # Parameters: k:int the size of each group
    # Return: List[List[Plane]] the list of groups
    # Exceptions: k <= 0
    def form_groups_of_planes_same_dest_diff_companies(self, k:int) -> List[List[Plane]]:
        return Sorting.groups_of(k, self.__planes,
                                 partial(lambda plane1, plane2:
                                 [plane1.destination == plane2.destination and
                                 plane1.airline_company == plane2.airline_company]))
