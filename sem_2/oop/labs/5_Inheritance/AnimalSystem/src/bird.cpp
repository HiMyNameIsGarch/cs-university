#include "../include/bird.h"

#include <iostream>

using std::cout;
using std::endl;

void Bird::displayInfo() const {
    cout << "Common name: " << commonName << endl;
    cout << "Scientific name: " << scientificName << endl;
    cout << "Wing span: " << m_wingSpan << " cm" << endl;
}
