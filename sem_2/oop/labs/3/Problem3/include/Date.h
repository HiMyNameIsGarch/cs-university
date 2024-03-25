#ifndef DATE_H
#define DATE_H

#include <iostream>

class Date {
private:
    int d;
    int m;
    int y;
public:
    // A
    Date();
    Date(int day, int month, int year);

    // getters
    const int &day() const { return d;};
    const int &month() const { return m;};
    const int &year() const { return y;};

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
