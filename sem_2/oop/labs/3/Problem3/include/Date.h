#ifndef DATE_H
#define DATE_H

#include <iostream>

class Date {
private:
    int day;
    int month;
    int year;
public:
    // A
    Date();
    Date(int day, int month, int year);

    // B
    friend std::ostream& operator<<(std::ostream& os, const Date& date);

    // C
    bool operator==(const Date& other);
    bool operator!=(const Date& other);

    bool operator<=(const Date& other);
    bool operator<(const Date& other);

    bool operator>=(const Date& other);
    bool operator>(const Date& other);

    // D
    void addDays(int numDays);

    // E
    static bool isValidDate(int year, int month, int day);
};

#endif
