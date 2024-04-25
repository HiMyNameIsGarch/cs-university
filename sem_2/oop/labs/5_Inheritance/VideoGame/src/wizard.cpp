#include "../include/wizard.h"

Wizard::Wizard(string name, int health, int level): Character(name, health, level) {
    m_mana = BASE_MANA;
    m_spellPower = BASE_SPELLPOWER;
    m_spells = {"Fireball", "Ice Shard", "Lightning Bolt"};
}

bool Wizard::castSpell(string spell) {
    bool found = false;
    for(string &s: m_spells) {
        if (s == spell) {
            found = true;
        }
    }

    if(!found)
        return false;

    if(m_mana - 10 < 0)
        return false;

    // cast the spell
    m_mana -= 10;

    return true;
}

