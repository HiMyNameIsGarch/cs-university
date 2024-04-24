#pragma once
#include "animal.h"
#ifndef REPTILE_H
#define REPTILE_H

class Reptile: public Animal {
private:
    bool m_isVenomous;

public:
    void displayInfo() const;

    Reptile(string cname, string sname, bool isVenomous): Animal{ cname, sname } {
        m_isVenomous = isVenomous;
    }

    // Getters
    bool getIsVenomous() const {
        return m_isVenomous;
    }

    // Setters
    void setIsVenomous(bool isVenomous) {
        m_isVenomous = isVenomous;
    }

};

#endif
