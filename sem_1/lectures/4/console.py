import logic

def print_menu():
    print("My menu here haha")

def read_option():
    return input("My option is: ")

def main():
    stop = True
    while stop:
        print_menu()
        n = read_option()
        if n == 1:
            print(logic.get_student_list())
        elif n == 2:
            name = input("Give a name: ")
            grade = int(input("Give a grade: "))
            logic.add_student(name, grade)
            print(logic.get_student_list())
        elif n == 3:
            name = input("Name: ")
            print(logic.find_student_by_name(name))
        elif n == 4:
            val = int(input("Give a value: "))
            print(logic.get_stud_by_grade(val))
        else:
            stop = False

