import uuid

class Passenger:
    def __init__(self, fname:str, lname:str, passport_number:str):
        self.__id:uuid.UUID = uuid.uuid4()
        self.__first_name:str = fname
        self.__last_name:str = lname
        self.__passport_number:str = passport_number

    # overload lower than operator
    def __lt__(self, other):
        # print(self.last_name, other.last_name)
        return self.__last_name.lower() < other.__last_name.lower()

    def __gt__(self, other):
        return not self.__lt__(other) and not self.__eq__(other)

    def __gte__(self, other):
        return not self.__lt__(other)

    def __lte__(self, other):
        return self.__lt__(other) or self.__eq__(other)

    def __ne__(self, __value: object) -> bool:
        return not self.__eq__(__value)

    # overload equal operator
    def __eq__(self, other):
        if not isinstance(other, Passenger):
            return False
        return self.__last_name.lower() == other.__last_name.lower()

    def __str__(self) -> str:
        return f"{self.__first_name} {self.__last_name} {self.__passport_number}"

    __repr__ = __str__

    @property
    def id(self) -> uuid.UUID:
        return self.__id

    @property
    def full_name(self) -> str:
        return self.__first_name + " " + self.__last_name

    @property
    def first_name(self) -> str:
        return self.__first_name

    @first_name.setter
    def first_name(self, fname:str) -> None:
        self.__first_name = fname

    @property
    def last_name(self) -> str:
        return self.__last_name

    @last_name.setter
    def last_name(self, lname:str) -> None:
        self.__last_name = lname

    @property
    def passport_number(self) -> str:
        return self.__passport_number

    @passport_number.setter
    def passport_number(self, num:str) -> None:
        self.__passport_number = num
