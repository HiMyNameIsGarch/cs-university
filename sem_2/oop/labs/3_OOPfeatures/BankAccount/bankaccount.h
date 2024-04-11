#ifndef BANKACC_H
#define BANKACC_H

#include <iostream>
#include <cmath>

class BankAccount {
    private :
        double balance;
    public:
        std::string name;
        uint accountNumber;

        BankAccount(std::string name, uint accnum, double initBalance);
        void deposit(double sum);
        void withdraw(double sum);

        friend std::ostream& operator<<(std::ostream& os, const BankAccount& acc);
};

#endif
