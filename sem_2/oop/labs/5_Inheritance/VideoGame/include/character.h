#pragma once

#include <iostream>
using std::string;

#ifndef CHARACTER_H
#define CHARACTER_H

class Character {
protected:
    string m_name;
    int m_health;
    int m_level;

private:

public:
    string name() const {
        return m_name;
    }
    void setName(string newName){
        m_name = newName;
    }
    int health() const {
        return m_health;
    }
    void sethealth(int newhealth){
        m_health = newhealth;
    }
    int level() const {
        return m_level;
    }
    void setLevel(int newLevel){
        m_level = newLevel;
    }

    Character();
    Character(string name, int health, int level);
};

#endif
