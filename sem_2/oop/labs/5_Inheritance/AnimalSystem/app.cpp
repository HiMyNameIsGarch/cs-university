#include <iostream>
#include "include/bird.h"
#include "include/mammal.h"
#include "include/reptile.h"

int main() {
    Animal b = *new Bird("American Robin", "Turdus", 20);
    Mammal m("Grizzly Bear", "Ursus", false, 220);
    Reptile r("King Cobra", "Ophiophagus", true);
    Animal a("Animal", "Animal");

    b.displayInfo();
    std::cout << std::endl;
    m.displayInfo();
    std::cout << std::endl;
    r.displayInfo();
    std::cout << std::endl;
    a.displayInfo();
    return 0;
}

