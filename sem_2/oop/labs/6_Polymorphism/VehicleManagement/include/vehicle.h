#pragma once
#include <iostream>
using std::string;

#ifndef VEHICLE_H
#define VEHICLE_H

class Vehicle {
protected:
    string m_registrationNumber;

public:
    virtual void display();

    Vehicle(string regNum);

    virtual ~Vehicle() = default;

};

#endif
