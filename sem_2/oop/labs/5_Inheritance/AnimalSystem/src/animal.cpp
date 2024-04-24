#include "../include/animal.h"
#include <iostream>

using std::cout;
using std::endl;

Animal::Animal(string cname, string sname) {
    commonName = cname;
    scientificName = sname;
}

void Animal::displayInfo() const {
    cout << "Common name: " << commonName << endl;
    cout << "Scientific name: " << scientificName << endl;
}
