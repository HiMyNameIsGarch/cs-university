#include "../include/comboMenu.h"
#include <vector>

ComboMenu::ComboMenu() {
    count = 0;
    m_menus = {};
}

void ComboMenu::addItem(SimpleMenuItem *item) {
    if(count > 3){
        throw std::length_error("You cannot add more than 4 menu items in a combo menu.");
    }
    m_menus.push_back(item);
    count++;
}

void ComboMenu::display() const {
    for(auto &menu: m_menus) {
        menu->display();
        std::cout << std::endl;
    }
}
