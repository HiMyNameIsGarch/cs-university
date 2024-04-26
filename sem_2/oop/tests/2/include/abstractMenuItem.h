#pragma once
#include <iostream>
using std::string;
#ifndef ABSTRACTMENUITEM_H
#define ABSTRACTMENUITEM_H

class AbstractMenuItem {
protected:
    string m_name;
    bool m_suitableForVegetarians;
    double m_price;

private:

public:

    virtual ~AbstractMenuItem() = default;
    double price() const {
        return m_price;
    }
    void setPrice(double newPrice){
        if(newPrice < 1) {
            throw std::invalid_argument("The price cannot be negative");
        }
        m_price = newPrice;
    }

    string name() const {
        return m_name;
    }
    void setName(string newName){
        m_name = newName;
    }

    bool suitableForVegetarians() const {
        return m_suitableForVegetarians;
    }
    void setSuitableForVegetarians(bool newSuitableForVegetarians){
        m_suitableForVegetarians = newSuitableForVegetarians;
    }

    virtual void display() const;

    friend std::istream& operator >>(std::istream& is, AbstractMenuItem& item);

    AbstractMenuItem();
    AbstractMenuItem(const AbstractMenuItem &) = default;
    AbstractMenuItem(AbstractMenuItem &) = default;
    AbstractMenuItem &operator=(const AbstractMenuItem &) = default;
    AbstractMenuItem &operator=(AbstractMenuItem &&) = default;
    AbstractMenuItem(double price, bool forVegs, string name);
};

#endif
