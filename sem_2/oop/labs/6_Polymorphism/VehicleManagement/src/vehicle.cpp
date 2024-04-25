#include "../include/vehicle.h"

Vehicle::Vehicle(string regNum) {
    m_registrationNumber = regNum;
}

void Vehicle::display() {
    std::cout << "Vehicle: " << std::endl;
    std::cout << "Reg Num: " << m_registrationNumber << std::endl;
}
