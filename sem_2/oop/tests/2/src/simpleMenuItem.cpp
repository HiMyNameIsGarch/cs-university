#include "../include/simpleMenuItem.h"

SimpleMenuItem::SimpleMenuItem(string type, string name, bool forVegs, double price) :
AbstractMenuItem{price, forVegs, name} {
    m_menuType = type;
}

void SimpleMenuItem::display() const {
    AbstractMenuItem::display();
    std::cout << "Menu Type: " << m_menuType << std::endl;
}

SimpleMenuItem SimpleMenuItem::operator=(const SimpleMenuItem* item) {
    SimpleMenuItem menu = SimpleMenuItem();
    menu.m_menuType = item->menuType();
    menu.m_name = item->name();
    menu.m_suitableForVegetarians = item->suitableForVegetarians();
    menu.m_price = item->price();
    return menu;
}
