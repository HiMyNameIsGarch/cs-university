#include "../include/mammal.h"

#include <iostream>

using std::cout;
using std::endl;

void Mammal::displayInfo() const {
    cout << "Common name: " << commonName << endl;
    cout << "Scientific name: " << scientificName << endl;
    cout << "Is aquatic: " << m_aquatic << endl;
    cout << "Gestation Period: " << m_gestationPeriod << endl;
}

