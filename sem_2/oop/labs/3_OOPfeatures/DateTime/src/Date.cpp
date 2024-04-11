#include "../include/Date.h"

bool Date::isValidDate(int year, int month, int day) {
    if (year < 0 || month < 1 || month > 12 || day < 1) {
        return false;
    }
    if (month == 2) {
        if (year % 4 == 0) {
            if (day > 29) {
                return false;
            }
        } else {
            if (day > 28) {
                return false;
            }
        }
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
        if (day > 30) {
            return false;
        }
    } else {
        if (day > 31) {
            return false;
        }
    }
    return true;
}

Date::Date() {
    this->y = 1970;
    this->m = 1;
    this->d = 1;
}

Date::Date(int y, int m, int day) {
    if (isValidDate(y, m, day)) {
        this->y = y;
        this->m = m;
        this->d = day;
    } else {
        this->y = 1970;
        this->m = 1;
        this->d = 1;
    }
}

std::ostream& operator<<(std::ostream& os, const Date& date) {
    os << "Year: " << date.y << std::endl << "Month: " << date.m << std::endl << "Day: " << date.d << std::endl;
    return os;
}

bool Date::operator==(const Date& date) const {
    return this->y == date.y && this->m == date.m&& this->d == date.d;
}

bool Date::operator!=(const Date& date) const {
    return !(*this == date);
}

bool Date::operator<(const Date& date) const{
    if (this->y < date.y) {
        return true;
    } else if (this->y == date.y) {
        if (this->m < date.m) {
            return true;
        } else if (this->m == date.m) {
            if (this->d < date.d) {
                return true;
            }
        }
    }
    return false;
}
bool Date::operator<=(const Date& date) const {
    return (*this == date) || (*this < date);
}

bool Date::operator>(const Date& date) const {
    return !(*this < date);
}
bool Date::operator>=(const Date& date) const {
    return (*this == date) || (*this > date);
}
void Date::addDays(int numDays) {
    if (numDays < 0) {
        return;
    }
    int daysInMonth = 0;
    while (numDays > 0) {
        if (this->m == 2) {
            if (this->y % 4 == 0) {
                daysInMonth = 29;
            } else {
                daysInMonth = 28;
            }
        } else if (this->m == 4 || this->m == 6 || this->m == 9 || this->m == 11) {
            daysInMonth = 30;
        } else {
            daysInMonth = 31;
        }
        if (this->d + numDays > daysInMonth) {
            numDays -= daysInMonth - this->d + 1;
            this->d = 1;
            if (this->m == 12) {
                this->m = 1;
                this->y++;
            } else {
                this->m++;
            }
        } else {
            this->d += numDays;
            numDays = 0;
        }
    }
}
