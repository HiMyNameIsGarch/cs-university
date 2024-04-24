#include "../include/reptile.h"

#include <iostream>

using std::cout;
using std::endl;

void Reptile::displayInfo() const {
    cout << "Common name: " << commonName << endl;
    cout << "Scientific name: " << scientificName << endl;
    cout << "Is venomous: " << m_isVenomous << endl;
}

