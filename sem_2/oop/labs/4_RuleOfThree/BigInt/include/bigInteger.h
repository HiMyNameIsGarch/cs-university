#pragma once
#ifndef BIGINTEGER_H
#define BIGINTEGER_H
#include <iostream>

// Space optimized version of simple implementation
struct digit {
    int value : 4;
};

class BigInteger {

private:
    digit *digits;
    int sz;
    // The sign of the integer to store the number
    bool sign;

public:
    // a constructors
    BigInteger(); // Init to 0
    BigInteger(std::string number); // numbers between 0 and 9

    // b comparing two big integers
    // - 1 if this < N and 0 if this == N and 1 if this > N
    int compare(const BigInteger *N) const;

    // c overloaders
    bool operator==(const BigInteger &N) const;
    bool operator!=(const BigInteger &N) const;
    bool operator<(const BigInteger &N) const;
    bool operator>(const BigInteger &N) const;
    bool operator<=(const BigInteger &N) const;
    bool operator>=(const BigInteger &N) const;

    // f rule of three
    // copy constructor
    BigInteger(const BigInteger &N);
    // copy assignment
    BigInteger &operator=(const BigInteger &N);
    // destructor
    ~BigInteger();

    // g arithmetic operations
    BigInteger operator+(const BigInteger &N) const;
    BigInteger operator-(const BigInteger &N) const;

    // h output
    BigInteger operator+(const BigInteger &N);
    BigInteger operator+=(const BigInteger &N);
    BigInteger operator-(const BigInteger &N);
    BigInteger operator-=(const BigInteger &N);

    // Auxiliary functions
    void prepandZeros(int n);
    void negate();
    BigInteger addTwoArrays(BigInteger *N, BigInteger *M);
    void digitize(std::string number);

    std::string to_string() const;

    friend std::ostream &operator<<(std::ostream &os, const BigInteger &N);

    // increment and decrement
    BigInteger operator++();
    BigInteger operator++(int);

};

#endif
