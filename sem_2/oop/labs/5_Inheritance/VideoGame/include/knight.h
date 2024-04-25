#pragma once
#include "character.h"
#include <iostream>
#ifndef KNIGHT_H
#define KNIGHT_H

#define BASE_ARMOR 0.5
#define BASE_DAMAGE 2

class Knight:public Character {

private:
    double m_armor;
    int m_swordDamage;
    void setArmor(double newArmor){
        if(newArmor < 0 || newArmor > 1) {
            return;
        }
        m_armor = newArmor;
    }

public:
    void takeDamage(int damage);

    Knight(string name, int health, int level);

    double armor() const {
        return m_armor;
    }

};

#endif
