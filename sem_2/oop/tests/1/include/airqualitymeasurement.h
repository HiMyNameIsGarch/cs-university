#ifndef AIRQUALITY_H
#define AIRQUALITY_H

#include "../include/mytime.h"
#define MIN_QUALITY 0
#define MAX_QUALITY 500


class AirQualityMeasurement {
private:
    int air_index;
    Time air_time;

    // static
    static int purple_reg;

public:
    AirQualityMeasurement();
    AirQualityMeasurement(int idx, Time t);

    // getters
    int index() const { return air_index;};
    Time time() const { return air_time;};

    static int purple_has_registered() { return purple_reg;};

    // setters
    void set_air_index(int new_air_index);
    void set_air_time(Time new_time);

    friend std::ostream& operator<<(std::ostream& os, const AirQualityMeasurement& air);
    friend std::istream& operator>>(std::istream& is, AirQualityMeasurement& air);

    static std::string convert_air_to_color(const int air_idx);

};
#endif
