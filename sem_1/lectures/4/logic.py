import console as co
students = [("Ana", 12), ("Dani", 14)]
def add_student(name, grade):
    students.append((name, grade))

def find_student_by_name(name):
    return [i for i in students if i[0] == name]

def get_student_list():
    return students

def to_string():
    s = ""
    for elem in students:
        s += elem[0] + " - " + elem[1] + "\n"
    return s

def del_stud_by_(name):
    for i in range(len(students)-1, -1, -1):
        if(students[i][0] == name):
            students.pop(i)

def get_stud_by_grade(val):
    res = []
    for elem in students:
        if elem [1] > val:
            res.append(elem)
    return res
