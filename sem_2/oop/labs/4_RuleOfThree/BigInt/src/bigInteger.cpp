#include "../include/bigInteger.h"

// a constructors
BigInteger::BigInteger() {
    digits = new digit[1];
    digits[0].value = 0;
    sz = 1;
    sign = 0;
}

BigInteger::BigInteger(std::string number) {
    digitize(number);
}

// b comparing two big integers
int BigInteger::compare(const BigInteger *N) const {
    if (sz < N->sz) {
        return -1;
    } else if (sz > N->sz) {
        return 1;
    } else {
        for (int i = sz - 1; i >= 0; i--) {
            if (digits[i].value < N->digits[i].value) {
                return -1;
            } else if (digits[i].value > N->digits[i].value) {
                return 1;
            }
        }
    }
    return 0;
}

// c overloaders
bool BigInteger::operator==(const BigInteger &N) const {
    return compare(&N) == 0;
}

bool BigInteger::operator!=(const BigInteger &N) const {
    return compare(&N) != 0;
}

bool BigInteger::operator<(const BigInteger &N) const {
    return compare(&N) == -1;
}

bool BigInteger::operator>(const BigInteger &N) const {
    return compare(&N) == 1;
}

bool BigInteger::operator<=(const BigInteger &N) const {
    return compare(&N) != 1;
}

bool BigInteger::operator>=(const BigInteger &N) const {
    return compare(&N) != -1;
}

// f rule of three
// copy constructor
BigInteger::BigInteger(const BigInteger &N) {
    digits = new digit[N.sz];
    sz = N.sz;
    for (int i = 0; i < sz; i++) {
        digits[i].value = N.digits[i].value;
    }
}

// copy assignment
BigInteger &BigInteger::operator=(const BigInteger &N) {
    if (this != &N) {
        delete[] digits;
        digits = new digit[N.sz];
        sz = N.sz;
        for (int i = 0; i < sz; i++) {
            digits[i].value = N.digits[i].value;
        }
    }
    return *this;
}

// destructor
BigInteger::~BigInteger() {
    delete[] digits;
}

BigInteger BigInteger::operator++() {
    return *this += BigInteger("1");
}
BigInteger BigInteger::operator++(int) {
    BigInteger temp(*this);
    *this += BigInteger("1");
    return temp;
}

// to string
std::string BigInteger::to_string() const {
    std::string str;
    for (int i = sz - 1; i >= 0; i--) {
        str += std::to_string(digits[i].value);
    }
    return str;
}

// stream operator
std::ostream &operator<<(std::ostream &os, const BigInteger &N) {
    os << N.to_string();
    return os;
}

// g arithmetic operations
BigInteger BigInteger::operator+(const BigInteger &N) const {
    return BigInteger();
}

BigInteger BigInteger::operator-(const BigInteger &N) const {
    return BigInteger();
}

// h output
BigInteger BigInteger::operator+(const BigInteger &N) {
    return *this + N;
}

BigInteger BigInteger::operator+=(const BigInteger &N) {
    return *this = *this + N;
}

BigInteger BigInteger::operator-(const BigInteger &N) {
    return *this - N;
}

BigInteger BigInteger::operator-=(const BigInteger &N) {
    return *this = *this - N;
}
