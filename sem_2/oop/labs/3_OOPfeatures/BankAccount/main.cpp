#include <iostream>
#include "bankaccount.h"

int main() {
    BankAccount acc("Gigi", 123, 1);
    std::cout << acc << std::endl;
    acc.withdraw(100);
    std::cout << acc << std::endl;
}
