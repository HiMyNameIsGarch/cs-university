#include "complex.h"
#include "displaytype.h"
#include <cmath>

// init static variable
DisplayType Complex::dt = DisplayType::RECTANGULAR_FORM;

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
double Complex::magnitude() const {
    double mag = std::sqrt((this->r * this->r) + (this->i * this->i));
    return mag;
}

double Complex::phase() const {
    double phase = std::atan(this->i / this->r);
    return phase;
}

// D
DisplayType Complex::DISPLAY_TYPE() {
    return Complex::dt;
}

void Complex::DISPLAY_TYPE(DisplayType newType) {
    Complex::dt = newType;
}

// E
std::ostream& operator<<(std::ostream& os, const Complex& point) {
    if (Complex::DISPLAY_TYPE() == DisplayType::RECTANGULAR_FORM) {
        os << "(" << point.r << " + " << point.i << "*i)\n";
    } else {
        double cos = std::cos(point.phase());
        double sin = std::sin(point.phase());
        os << "z=" << point.magnitude() << " * (" << cos << " + i" << sin << ")" << "\n";
    }
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
