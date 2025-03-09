#pragma once
#include <iostream>
using std::string;
#ifndef STUDENT_H
#define STUDENT_H

class Student {
protected:

private:
    int m_id;
    string m_name;
    string m_course;
    int m_grade;

public:
    // constructor
    Student();
    Student(int id, string name, string course, int grade);
    virtual ~Student() = default;
    int grade() const {
        return m_grade;
    }
    void setGrade(int newGrade){
        if(newGrade < 0 || newGrade > 100)
            throw std::invalid_argument("Invalid grade");
        m_grade = newGrade;
    }

    // read and write accessors for the name member variable
    friend std::ostream& operator<<(std::ostream& out, const Student& s);
    friend std::istream& operator>>(std::istream& in, Student& s);

};

#endif
