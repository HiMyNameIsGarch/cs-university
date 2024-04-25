#pragma once
#include "vehicle.h"
#include <iostream>
#include <vector>
using std::string;
#ifndef GARAGE_H
#define GARAGE_H

class Garage {
protected:

private:
    std::vector<Vehicle*> m_vehicles;

public:
    void addVehicle(Vehicle* vehicle);

    void display();

    Garage();

};

#endif
