#include "../include/character.h"

// constructors
Character::Character() {
    m_name = "";
    m_level = 0;
    m_health = 0;
}
Character::Character(string name, int health, int level) {
    m_name = name;
    m_level = level;
    m_health = health;
}

