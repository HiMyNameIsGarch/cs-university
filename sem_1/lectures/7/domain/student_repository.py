from domain.student import Student
class StudentRepository:
    def __init__(self) -> None:
        self.__data:list[Student] = []

    def get_data(self) -> list:
        return self.__data

    def muie(self):
        d ={}
        for stud in self.__data:
            g = d[stud.get_group()]
            d[stud.get_group()] = stud.get_avg_grade() > g
    def add_student(self, stud:Student, group):
        self.__data.append(stud)
        group = [i for i in self.__data if i.get_group() == group]

    def stud_get_avg_grade(self) -> Student:
        if len(self.__data) < 1: return Student(3, "Mama", 813, [2,3,4,1,2])
        max = self.__data[0].get_avg_grade()
        max_stud = self.__data[0]
        for stud in self.__data:
            c = stud.get_avg_grade()
            if c > max:
                max_stud = stud
        return max_stud

