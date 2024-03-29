#pragma once
#ifndef TIME_H
#define TIME_H

#define MIN_HOUR 0
#define MAX_HOUR 23

#define MIN_MINUTES 0
#define MAX_MINUTES 59

#define MIN_SECONDS 0
#define MAX_SECONDS 59

#include <iostream>

class Time {
private:
    int h;
    int m;
    int s;

public:
    // Constructors
    Time();
    Time(int hour, int minutes, int seconds);

    // getters
    int hour() const { return h;};
    int minutes() const { return m;};
    int seconds() const { return s;};

    // setters
    void setHour(int new_hour);
    void setMinutes(int new_minutes);
    void setSeconds(int new_seconds);

    // Stream insertion operator
    friend std::istream& operator>>(std::istream& is, Time& t);

    // Operators
    bool operator==(const Time& other) const;
    bool operator<(const Time &other) const;

};
#endif
