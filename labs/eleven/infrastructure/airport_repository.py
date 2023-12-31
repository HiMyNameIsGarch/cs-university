from domain.plane import Plane
from domain.sorting import Sorting
from typing import List, Optional

class Airport_Repository:
    def __init__(self, planes:Optional[List[Plane]]=None) -> None:
        if planes is None:
            planes = []
        self.__planes:List[Plane] = planes

    def add_plane(self, plane:Plane) -> None:
        if plane in self.__planes:
            raise Exception("Plane already exists")

        self.__planes.append(plane)

    def remove_plane(self, plane:Plane) -> None:
        if plane not in self.__planes:
            raise Exception("Plane not found")

        self.__planes.remove(plane)

    @property
    def planes(self) -> List[Plane]:
        return self.__planes

    # 4
    def sort_by_number_of_passengers(self) -> List[Plane]:
        return Sorting.sort(self.planes, lambda plane:
            plane.no_of_passengers)
    # 5
    def sort_by_no_of_passengers_and_name_starting_with(self, letter:str) -> List[Plane]:
        return Sorting.sort([plane for plane in self.__planes if
            Sorting.filter(plane.passengers, lambda passenger:
                passenger.full_name.__contains__(letter))], lambda plane:
                    plane.no_of_passengers)
    # 6
    def sort_by_concat_nums_of_passengers_and_destination(self) -> List[Plane]:
        return Sorting.sort(self.__planes, lambda plane:
            plane.passengers_and_destination)

    # 7
    def get_planes_starting_with_the_same_3_letters(self) -> List[Plane]:
        return [plane for plane in self.__planes if
            Sorting.filter(plane.passengers, lambda passenger:
                passenger.passport_number.startswith(passenger.passport_number[0:3]))]

    # 9
    def get_planes_where_is_the_passenger_named(self, name:str) -> List[Plane]:
        return [plane for plane in self.__planes if
            Sorting.filter(plane.passengers, lambda passenger:
                passenger.full_name == name)]
    # 11 - TODO
    def form_groups_of_planes_same_dest_diff_companies(self, k:int) -> List[List[Plane]]:
        return Sorting.groups_of(k, self.__planes, lambda plane:
            plane.destination)
