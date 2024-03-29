#include "../include/airqualitymeasurement.h"
#include "../include/mytime.h"
#include <cstdio>

int AirQualityMeasurement::purple_reg = 0;

AirQualityMeasurement::AirQualityMeasurement() {
    this->air_index = MIN_QUALITY + rand() % (MAX_QUALITY - MIN_QUALITY + 1);;

    if (this->air_index >= 201 && this->air_index <=300) {
        this->purple_reg += 1;
    }

    this->air_time = Time();
}
AirQualityMeasurement::AirQualityMeasurement(int idx, Time t) {
    this->set_air_index(idx);
    if (this->air_index >= 201 && this->air_index <=300) {
        this->purple_reg += 1;
    }
    this->set_air_time(t);
}

void AirQualityMeasurement::set_air_time(Time new_time){
    this->air_time = new_time;
}
void AirQualityMeasurement::set_air_index(int new_index){
    if(new_index < MIN_QUALITY || new_index > MAX_QUALITY)  {
        return;
    }
    this->air_index = new_index;

    if (this->air_index >= 201 && this->air_index <= 300) {
        this->purple_reg += 1;
    }
}

std::ostream& operator<<(std::ostream& os, const AirQualityMeasurement& air) {
    os << "Air index: " << air.index() << "\n";
    os << "Air time: " << air.time().hour() << "H " << air.time().minutes() << "m " << air.time().seconds() << "s\n";
    return os;
}
std::istream& operator>>(std::istream& is, AirQualityMeasurement& air) {
    Time t = Time();
    is >> t;
    air.set_air_time(t);
    int idx = 0;
    std::cout << "Put index value: ";
    is >> idx;
    air.set_air_index(idx);
    return is;
}

std::string AirQualityMeasurement::convert_air_to_color(const int air_idx) {
    if (air_idx >= 0 && air_idx <= 100) {
        return "green";
    }
    if (air_idx >= 101 && air_idx <= 150) {
        return "orange";
    }
    if (air_idx >= 151 && air_idx <= 200) {
        return "red";
    }
    if (air_idx >= 201 && air_idx <= 300) {
        return "purple";
    }
    if (air_idx >= 301) {
        return "maroon";
    }
    return "Out of bounds";
}
