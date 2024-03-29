#include "../include/mytime.h"
#include <iostream>
#include <cstdio>

Time::Time() {
    // Randomly generated
    this->h = MIN_HOUR + rand() % (MAX_HOUR - MIN_HOUR + 1);
    this->m = MIN_MINUTES + rand() % (MAX_MINUTES - MIN_MINUTES + 1);
    this->s = MIN_SECONDS + rand() % (MAX_SECONDS - MIN_SECONDS + 1);;
}

Time::Time(int hour, int minutes, int seconds) {
    this->h = hour;
    this->m = minutes;
    this->s = seconds;
}

void Time::setHour(int new_hour) {
    if(new_hour < MIN_HOUR || new_hour > MAX_HOUR) {
        return;
    }
    this->h = new_hour;
}
void Time::setMinutes(int new_minutes) {
    if(new_minutes < MIN_MINUTES || new_minutes > MAX_MINUTES) {
        return;
    }
    this->h = new_minutes;
}
void Time::setSeconds(int new_seconds) {
    if(new_seconds < MIN_SECONDS || new_seconds > MAX_SECONDS) {
        return;
    }
    this->h = new_seconds;
}

std::istream& operator>>(std::istream& is, Time& t) {
    int h = 0;
    is >> h;
    t.setHour(h);
    int m = 0;
    is >> m;
    t.setMinutes(m);
    int s = 0;
    is >> s;
    t.setSeconds(m);
    return is;
}

bool Time::operator==(const Time& other) const  {
    if (this->h != other.hour()) {
        return false;
    }
    if (this->m != other.minutes()) {
        return false;
    }
    if (this->s != other.seconds()) {
        return false;
    }
    return true;
}

bool Time::operator<(const Time& other) const {
    if (this->h > other.hour()) {
        return false;

    } else if (this->h == other.hour()) {
        if (this->m > other.minutes()) {
            return false;

        } else if (this->m == other.minutes()) {
            if (this->s > other.seconds()) {
                return false;

            } else if (this->s == other.seconds()) {
                return false;
            }
        }
    }
    return true;
}
