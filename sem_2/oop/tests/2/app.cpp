#include <iostream>
#include "include/menu.h"
#include "include/comboMenu.h"
#include "include/simpleMenuItem.h"

int main() {
    try {
        // 5 - create a Menu object and insert into it at least two ComboMenus and one SimpleMenuItem
        // Create at least 2 combo menus
        ComboMenu *cm1 = new ComboMenu();
        SimpleMenuItem *csm1 = new SimpleMenuItem("Dessert", "Simple menu 1", true, 12);
        SimpleMenuItem *csm2 = new SimpleMenuItem("Dessert", "Simple menu 2", false, 34);
        cm1->addItem(csm1);
        cm1->addItem(csm2);

        ComboMenu *cm2 = new ComboMenu();
        SimpleMenuItem *m1 = new SimpleMenuItem("Soup", "Simple menu 3", true, 10);
        SimpleMenuItem *m2 = new SimpleMenuItem("Beverage", "Simple menu 4", true, 7);
        cm2->addItem(m1);
        cm2->addItem(m2);

        // Create Simple menu item
        SimpleMenuItem *sm = new SimpleMenuItem("Dessert", "Simple menu 5", false, 25);

        // Add the items
        Menu m = Menu();
        m.addItem(cm1);
        m.addItem(cm2);
        m.addItem(sm);

        // b - read info abotu Simple Menu Item from user
        // SimpleMenuItem *userMenu = new SimpleMenuItem();
        // std::cin >> *userMenu;
        // m->addItem(userMenu);

        m.displayAll();
        // Display only desserts
        std::cout << "Display only desserts: " << std::endl;
        m.displayDesserts();

        delete cm1;
        delete cm2;
        delete sm;

    } catch(std::length_error& e) {
        std::cerr << "Length error caught" << std::endl;
        std::cerr << "Message: " << e.what() << std::endl;

    } catch(std::exception& e) {
        std::cerr << "General exception caught" << std::endl;
        std::cerr << "Message: " << e.what() << std::endl;

    } catch(...) {
        std::cerr << "Any type of exception caught" << std::endl;
    }
    return 0;
}
