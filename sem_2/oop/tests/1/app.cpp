#include <iostream>
#include "include/airqualitymeasurement.h"
#include <time.h>

#define MAX_ARRAY 48
#define MAX_AVG_HOUR 17
#define BEGIN_AVG 4

int main() {
    srand(time(0));

    AirQualityMeasurement *array = new AirQualityMeasurement[MAX_ARRAY];

    // from now on, use new operator to call explicitly the constructor
    AirQualityMeasurement *h1 = new AirQualityMeasurement();
    AirQualityMeasurement *h2 = new AirQualityMeasurement();

    // Heap allocated objects
    array[0] = *h1;
    array[1] = *h1;


    // User input
    std::cin >> array[2];
    std::cin >> array[3];

    // Default constructor
    for(int i = BEGIN_AVG; i < MAX_ARRAY; i++) {
        array[i] = AirQualityMeasurement();
    }

    // Color purple
    std::cout << "The color purple has been registered " << AirQualityMeasurement::purple_has_registered() << " times" << std::endl;

    // Time object
    Time time = Time(MAX_AVG_HOUR, 0 ,0);

    int avg_air_quality = 0;
    int max_air_quality = 0;
    for(int i = 0; i< MAX_ARRAY; i++) {
        if(array[i].time() < time) {
            avg_air_quality += array[i].index();

            if(array[i].index() > max_air_quality) {
                max_air_quality = array[i].index();
            }
        }
    }
    avg_air_quality = avg_air_quality % MAX_ARRAY;

    std::cout << "Average air quality index: " << avg_air_quality << " Color: "  << AirQualityMeasurement::convert_air_to_color(avg_air_quality) << std::endl;

    std::cout << "Maximum air quality index: " << max_air_quality << " Color: " << AirQualityMeasurement::convert_air_to_color(max_air_quality) << std::endl;

    free(h1);
    free(h2);

    delete [] array;
    return 0;
}

