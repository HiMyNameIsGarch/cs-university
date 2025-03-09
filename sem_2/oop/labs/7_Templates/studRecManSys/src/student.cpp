#include "../include/student.h"

// Constructor
Student::Student() : m_id(0), m_name(""), m_course(""), m_grade(0) {}

Student::Student(int id, string name, string course, int grade) {
    m_id = id;
    m_name = name;
    m_course = course;
    setGrade(grade);
}

// Overloaded stream insertion operator
std::ostream& operator<<(std::ostream& out, const Student& s) {
    out << "ID: " << s.m_id << "\n"
        << "Name: " << s.m_name << "\n"
        << "Course: " << s.m_course << "\n"
        << "Grade: " << s.m_grade << "\n";
    return out;
}

// Overloaded stream extraction operator
// Note that the input comes from a file, so we don't need to check for invalid input
// We can assume that the input is well-formed
// id, name, course, grade
std::istream& operator>>(std::istream& in, Student& s) {
    // use the set grade function
    in >> s.m_id >> s.m_name >> s.m_course >> s.m_grade;
    return in;
}

