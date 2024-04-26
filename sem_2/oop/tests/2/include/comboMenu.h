#pragma once
#include "abstractMenuItem.h"
#include "simpleMenuItem.h"
#include <vector>
#ifndef COMBOMENU_H
#define COMBOMENU_H
#define MAX_MENUS 3
#define DISCOUNT 25/100

class ComboMenu:public AbstractMenuItem {
private:
    std::vector<SimpleMenuItem*> m_menus = {};
    int count;

public:
    bool suitableForVegs() const {
        for(int i = 0; i < MAX_MENUS; i++) {
            if (!m_menus[i]->suitableForVegetarians()) {
                return false;
            }
        }
        return true;
    }

    double price() const {
        double total = 0;
        for(int i = 0; i < MAX_MENUS; i++) {
            total += m_menus[i]->price() - (double)DISCOUNT * m_menus[i]->price();
        }
        return total;
    }

    void addItem(SimpleMenuItem *newItem);

    void display() const override;

    ComboMenu();

    ~ComboMenu() {
        if(m_menus.empty())
            return;
        for (auto *menuItem : m_menus) {
            delete menuItem;
        }
    }
};

#endif
