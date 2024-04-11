#include "bankaccount.h"

BankAccount::BankAccount(std::string newname, uint accountNumber, double initBalance) {
    this->accountNumber = accountNumber;
    if (initBalance > 0) {
        this->balance = initBalance;
    }
    else {
        this->balance = 0;
    }
    this->name = newname;
}

void BankAccount::deposit(double sum) {
    if (sum < 5) {
        return;
    }
    this->balance += sum;
}

void BankAccount::withdraw(double sum) {
    if (sum < 5) {
        return;
    }
    if (sum > this-> balance) {
        return;
    }
    this->balance -= sum;
}

std::ostream& operator<<(std::ostream& os, const BankAccount& acc) {
    os << "Account name: " + acc.name + " Number: " << acc.accountNumber;
    return os;
}
