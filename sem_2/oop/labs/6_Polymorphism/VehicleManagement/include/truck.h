#pragma once

#include "vehicle.h"
#include <iostream>
using std::string;

#ifndef TRUCK_H
#define TRUCK_H

class Truck : public Vehicle {
private:
    double m_payloadCapacity;

public:
    double payloadCapacity() const {
        return m_payloadCapacity;
    }
    void setPayloadCapacity(double newPayloadCapacity){
        m_payloadCapacity = newPayloadCapacity;
    }

    void display() override;

    Truck(double cap, string regNum);

};

#endif
