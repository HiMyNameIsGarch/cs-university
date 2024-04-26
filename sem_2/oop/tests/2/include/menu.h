#pragma once
#include <vector>
#include <iostream>
#include "abstractMenuItem.h"
#include "simpleMenuItem.h"
#ifndef MENU_H
#define MENU_H

class Menu {
private:
    std::vector<AbstractMenuItem*> m_items = {};

public:

    std::vector<AbstractMenuItem*> items() const {
        return m_items;
    }

    // optional (uff sad)
    void displayItemsSuitableFor(std::string dietaryRestriction);

    void addItem(AbstractMenuItem* item);

    friend std::istream& operator >>(std::istream& is, Menu* menu);

    void displayDesserts() const;

    void displayAll() const;

};

#endif
