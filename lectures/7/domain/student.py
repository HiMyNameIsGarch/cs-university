class Student:
    def __init__(self, id, name, group, grades=[]):
        self.__id = id
        self.__name = name
        self.__group = group
        self.__grades = grades[:]

    def get_name(self):
        return self.__name

    def get_group(self):
        return self.__group

    def set_name(self, new_name):
        self.__name = new_name

    def __str__(self) -> str:
        return f"{str(self.__id)}, {self.__name}, {self.__group}, {self.__grades} "

    def __repr__(self) -> str:
        return str(self)

    def get_avg_grade(self) -> int:
        return 0
