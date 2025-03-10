#ifndef COMPLEX_H
#define COMPLEX_H

#include <iostream>
#include <cmath>
#include "displaytype.h"

class Complex {
private :
    // D
    static DisplayType dt;

public:
    double r;
    double i;

    // A
    Complex();
    Complex(double real, double imag);

    // B
    bool operator==(const Complex& other);
    bool operator!=(const Complex& other);

    // C
    double magnitude() const;
    double phase() const;

    // D
    static DisplayType DISPLAY_TYPE();

    static void DISPLAY_TYPE(DisplayType newType);

    // E
    friend std::ostream& operator<<(std::ostream& os, const Complex& point);
    friend std::istream& operator>>(std::istream& is, Complex& point);

    // F
    Complex operator+(const Complex& first) const;
    Complex operator-(const Complex& first) const;
    Complex operator*(const Complex& first) const;

    // G
    Complex operator*(const double& scalar) const;

};
#endif
