#include "../include/car.h"
#include <iostream>
using std::cout;
using std::endl;

Car::Car(string bodyType, string regNum): Vehicle(regNum) {
    m_bodyType = bodyType;
}

void Car::display() {
    cout << "Car: "<< endl;
    cout << "Body type: " << m_bodyType << " Reg Num: " << m_registrationNumber << endl;
}
