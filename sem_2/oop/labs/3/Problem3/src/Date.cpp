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
    this->year = 1970;
    this->month = 1;
    this->day = 1;
}

Date::Date(int year, int month, int day) {
    if (isValidDate(year, month, day)) {
        this->year = year;
        this->month = month;
        this->day = day;
    } else {
        this->year = 1970;
        this->month = 1;
        this->day = 1;
    }
}

std::ostream& operator<<(std::ostream& os, const Date& date) {
    os << "Year: " << date.year << std::endl << "Month: " << date.month << std::endl << "Day: " << date.day << std::endl;
    return os;
}

bool Date::operator==(const Date& date) {
    return this->year == date.year && this->month == date.month && this->day == date.day;
}

bool Date::operator!=(const Date& date) {
    return !(*this == date);
}

bool Date::operator<(const Date& date) {
    if (this->year < date.year) {
        return true;
    } else if (this->year == date.year) {
        if (this->month < date.month) {
            return true;
        } else if (this->month == date.month) {
            if (this->day < date.day) {
                return true;
            }
        }
    }
    return false;
}
bool Date::operator<=(const Date& date) {
    return (*this == date) || (*this < date);
}

bool Date::operator>(const Date& date) {
    return !(*this < date);
}
bool Date::operator>=(const Date& date) {
    return (*this == date) || (*this > date);
}
