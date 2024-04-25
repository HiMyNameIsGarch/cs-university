#pragma once

#include "vehicle.h"
#include <iostream>
using std::string;

#ifndef CAR_H
#define CAR_H

class Car : public Vehicle {
protected:

private:
    string m_bodyType;

public:
    string bodyType() const {
        return m_bodyType;
    }
    void setBodyType(string newBodyType){
        m_bodyType = newBodyType;
    }

    void display() override;

    Car(string bodyType, string regNum);

};

#endif
