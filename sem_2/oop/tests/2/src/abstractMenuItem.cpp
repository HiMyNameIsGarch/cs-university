#include "../include/abstractMenuItem.h"
#include <iostream>
using std::string;

AbstractMenuItem::AbstractMenuItem() {
    m_name = "";
    m_suitableForVegetarians = false;
    m_price = 0;
}

AbstractMenuItem::AbstractMenuItem(double price, bool forVegs, string name) {
    m_name = name;
    m_suitableForVegetarians = forVegs;
    setPrice(price);
}

std::istream& operator >>(std::istream& is, AbstractMenuItem& item) {
    item.display();
    string name;
    is >> name;
    item.setName(name);
    bool forVegs;
    is >> forVegs;
    item.setSuitableForVegetarians(forVegs);
    double price;
    is >> price;
    item.setPrice(price);
    return is;
}

void AbstractMenuItem::display() const {
    std::cout << "Name: " << m_name << std::endl;
    std::cout << "Is for vegetarians: " << m_suitableForVegetarians<< std::endl;
    std::cout << "Price :" << m_price << std::endl;
}
