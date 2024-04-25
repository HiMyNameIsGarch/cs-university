#include "../include/knight.h"

Knight::Knight(string name, int health, int level): Character(name, health, level) {
    m_armor = BASE_ARMOR;
    m_swordDamage = BASE_DAMAGE;
}

void Knight::takeDamage(int dmg) {
    double nArmor = (double)dmg * 1/10;
    if(m_armor - nArmor < 0) {
        sethealth(0);
        return;
    }
    setArmor(m_armor - nArmor);
    m_health -= dmg;
}

