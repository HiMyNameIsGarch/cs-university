#include "./include/DateTest.h"

int main() {
    Date a(2020, 2, 29);
    std::cout << a.day() << std::endl;
    std::cout << a.month()<< std::endl;
    return 0;
}
