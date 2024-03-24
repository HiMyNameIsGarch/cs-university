#include "complex.h"
// #include "displaytype.h"
#include <cmath>

Complex::Complex(double real, double imag) {
    this->i = imag;
    this->r = real;
}
Complex::Complex() {
    this->i = 1;
    this->r = 1;
}

// B
bool Complex::operator==(const Complex& other) {
    return this->r == other.r && this->i == other.i;
}

bool Complex::operator!=(const Complex& other) {
    return !(*this == other);
}

// C
double Complex::magnitude(const Complex& c) {
    double mag = std::sqrt((c.r * c.r) + (c.i * c.i));
    return mag;
}

double Complex::phase(const Complex& c) {
    double phase = std::atan(c.i / c.r);
    return phase;
}

// E
std::ostream& operator<<(std::ostream& os, const Complex& point) {
    // if (Complex::DISPLAY_TYPE() == DisplayType::POLAR_FORM) {
    //
    // }else {
    //
    // }
    os << point.r << " " << point.i << "i\n";
    return os;
}
std::istream& operator>>(std::istream& is, Complex& point) {
    std::cout << "Put real value: ";
    is >> point.r;
    std::cout << "Put imaginary value: ";
    is >> point.i;
    return is;
}
Complex Complex::operator+(const Complex& first) const {
    Complex c(first.r + this->r, first.i + this->i);
    return c;
}

Complex Complex::operator-(const Complex& other) const {
    Complex c(this->r - other.r, this->i - other.i);
    return c;
}

Complex Complex::operator*(const Complex& other) const {
    Complex c(this->r * other.r, this->i * other.i);
    return c;
}

Complex Complex::operator*(const double& scalar) const {
    Complex c(this->r * scalar, this->i * scalar);
    return c;
}
