#include "mandelbrot.h"
#include "complex.h"

int main()
{
    // Complex c(1,3);
    // std::cout << c;
    // std::cin >> c;
    // c.DISPLAY_TYPE(DisplayType::POLAR_FORM);
    // std::cout << c;
    // Optional mandelbrot set display in terminal
    display_mandelbrot(100, 25, 100);
    // getchar();
    return 0;
}
