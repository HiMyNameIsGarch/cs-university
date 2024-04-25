#include "../include/truck.h"
#include <iostream>
using std::cout;
using std::endl;

Truck::Truck(double cap, string regNum): Vehicle(regNum) {
    m_payloadCapacity = cap;
}

void Truck::display() {
    cout << "Truck: "<< endl;
    cout << "Payload Capacity: " << m_payloadCapacity << " Reg Num: " << m_registrationNumber << endl;
}


