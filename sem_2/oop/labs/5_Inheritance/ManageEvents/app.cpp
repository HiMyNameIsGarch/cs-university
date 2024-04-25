#include <iostream>
#include "include/concerts.h"
#include "include/workshop.h"
#include "include/conferences.h"


int main() {
    Concerts c1("Concert1", "2021-01-01", "Toronto", "Artist1");
    c1.displayEventDetails();
    std::cout << std::endl;
    Workshop w1("Workshop1", "2021-02-02", "Vancouver", "Topic1");
    w1.displayEventDetails();
    std::cout << std::endl;
    Conferences cf1("Conference1", "2021-03-03", "Calgary", "Speaker1");
    cf1.displayEventDetails();
    cf1.set("Travis");
    std::cout << std::endl;
    cf1.displayEventDetails();
    std::cout << std::endl;
    return 0;
}

