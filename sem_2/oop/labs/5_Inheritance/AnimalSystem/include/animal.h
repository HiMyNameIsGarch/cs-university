#pragma once
#ifndef ANIMAL_H
#define ANIMAL_H
#include <iostream>

using std::string;

class Animal {
protected:
    string commonName;
    string scientificName;

public:
    void displayInfo() const;
    Animal(string cname, string sname);

};

#endif
