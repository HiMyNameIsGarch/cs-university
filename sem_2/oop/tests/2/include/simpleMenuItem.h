#pragma once
#include <iostream>
using std::string;
#include "abstractMenuItem.h"
#ifndef SIMPLEMENUITEM_H
#define SIMPLEMENUITEM_H

class SimpleMenuItem: public AbstractMenuItem {
private:
    std::string m_menuType;

public:
    std::string menuType() const {
        return m_menuType;
    }
    void setMenuType(std::string newMenuType){
        m_menuType = newMenuType;
    }
    void display() const override;

    SimpleMenuItem() = default;
    SimpleMenuItem(string type, string name, bool forVegs, double price);

    SimpleMenuItem operator=(const SimpleMenuItem* item);

};

#endif
