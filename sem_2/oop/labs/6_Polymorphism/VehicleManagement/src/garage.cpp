#include "../include/garage.h"

void Garage::display() {
    for(auto &v: m_vehicles) {
        v->display();
        std::cout << std::endl;
    }
}

void Garage::addVehicle(Vehicle *v) {
    // add to the vector
    m_vehicles.push_back(v);
}

Garage::Garage() {
    m_vehicles = {};
}
