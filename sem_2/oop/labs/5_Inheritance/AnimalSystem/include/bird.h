#pragma once
#include "animal.h"
#ifndef BIRD_H
#define BIRD_H

class Bird: public Animal {
private:
    unsigned int m_wingSpan;

public:
    void displayInfo() const;

    Bird(string cname, string sname, unsigned int wingSpan): Animal{ cname, sname } {
        m_wingSpan = wingSpan;
    }

    // Getters
    unsigned int getWingSpan() const {
        return m_wingSpan;
    }

    // Setters
    void setWingSpan(unsigned int wingSpan) {
        m_wingSpan = wingSpan;
    }

};

#endif
