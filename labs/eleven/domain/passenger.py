import uuid

class Passenger:
    def __init__(self, fname:str, lname:str, passport_number:str):
        self.__id:uuid.UUID = uuid.uuid4()
        self.__first_name:str = fname
        self.__last_name:str = lname
        self.__passport_number:str = passport_number

    @property
    def id(self) -> uuid.UUID:
        return self.__id

    @property
    def full_name(self):
        return self.__first_name + " " + self.__last_name

    @property
    def first_name(self) -> str:
        return self.__last_name

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
