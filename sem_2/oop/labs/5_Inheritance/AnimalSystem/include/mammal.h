#pragma once
#include "animal.h"
#ifndef MAMMAL_H
#define MAMMAL_H

class Mammal : public Animal {
private:
    bool m_aquatic;
    unsigned char m_gestationPeriod;

public:
    void displayInfo() const;

    Mammal(string cname, string sname, bool aquatic, unsigned char gestationPeriod): Animal{ cname, sname } {
        m_aquatic = aquatic;
        m_gestationPeriod = gestationPeriod;
    }

    // Getters
    bool getAquatic() const {
        return m_aquatic;
    }
    unsigned char getGestationPeriod() const {
        return m_gestationPeriod;
    }
    // Setters
    void setAquatic(bool aquatic) {
        m_aquatic = aquatic;
    }
    void setGestationPeriod(unsigned char gestationPeriod) {
        m_gestationPeriod = gestationPeriod;
    }
};

#endif
