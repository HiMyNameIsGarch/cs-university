#pragma once
#include "character.h"
#include <iostream>
#include <vector>
using std::vector;
using std::string;

#ifndef WIZARD_H
#define WIZARD_H

#define BASE_MANA 100
#define BASE_SPELLPOWER 10
#define SPELL_POWER 20

class Wizard:public Character {
private:
    int m_mana;
    vector<string> m_spells;
    int m_spellPower = BASE_SPELLPOWER;

public:
    bool castSpell(string spell);
    Wizard(string name, int health, int level);

    int mana() const {
        return m_mana;
    }
    vector<string> spells() const {
        return m_spells;
    }
};

#endif
