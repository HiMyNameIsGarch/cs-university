#include "include/car.h"
#include "include/garage.h"
#include "include/truck.h"
#include <iostream>

int main() {
    // Create a Car object
    Car *c = new Car("Saloon", "5678");
    // Create a Truck object
    Truck *t = new Truck(1000, "9876");
    // Create a Garage object
    Garage g;
    g.addVehicle(t);
    g.addVehicle(c);
    g.display();
    return 0;
}

