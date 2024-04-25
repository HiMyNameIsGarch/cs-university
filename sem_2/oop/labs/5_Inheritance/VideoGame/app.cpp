#include "include/character.h"
#include "include/knight.h"
#include "include/wizard.h"
#include <iostream>

int main() {
    // Create a new character of each type
    Knight *k = new Knight("Sir Bob", 100, 1);
    Wizard *w = new Wizard("Wizard Bob", 100, 1);

    // Print out the character's name, health, and level
    std::cout << k->name() << " has " << k->health() << " health and is level " << k->level() << std::endl;
    std::cout << w->name() << " has " << w->health() << " health and is level " << w->level() << std::endl;

    // Play around with the characters
    k->takeDamage(10);
    w->castSpell("Fireball");

    // Print out the character's name, health, and level
    std::cout << k->name() << " has " << k->health() << " health and is level " << k->level() << std::endl;
    std::cout << w->name() << " has " << w->health() << " health and is level " << w->level() << std::endl;
    return 0;
}

