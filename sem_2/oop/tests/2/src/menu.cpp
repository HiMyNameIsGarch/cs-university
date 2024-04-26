#include "../include/menu.h"

std::istream& operator >>(std::istream& is, Menu* menu) {
    for(auto &item: menu->items()) {
        is >> *item;
    }
    return is;
}

void Menu::addItem(AbstractMenuItem *item) {
    if(!item) {
        return;
    }
    m_items.push_back(item);
}

void Menu::displayItemsSuitableFor(std::string dietaryRestriction) {
    std::cout << "optional: " << dietaryRestriction  << std::endl;
}

void Menu::displayDesserts() const {
    for(auto &item: m_items) {
        SimpleMenuItem *sm = dynamic_cast<SimpleMenuItem*>(item);
        if(!sm) {
            continue;
        }
        if(sm->menuType() == "Dessert") {
            sm->display();
        }

    }
}

void Menu::displayAll() const {
    for(auto &item: m_items) {
        item->display();
    }
}
