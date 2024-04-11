#include "complex.h"

void display_color(double value);

int mandelbrot(Complex c, int max_its) {
    double zReal = c.r;
    double zImag = c.i;

    for (double i = 0; i < max_its; ++i) {
        double r2 = zReal * zReal;
        double i2 = zImag * zImag;

        if (r2 + i2 > 4.0) return i;

        zImag = 2.0 * zReal * zImag + c.i;
        zReal = r2 - i2 + c.r;
    }
    return max_its;
}

void display_mandelbrot( int width, int height, int max_its) {
    const float x_start = -3.0f;
    const float x_fin = 1.0f;
    const float y_start = -1.0f;
    const float y_fin = 1.0f;
    double dx = (x_fin - x_start)/(width - 1);
    double dy = (y_fin - y_start)/(height - 1);

    for(int y = 0; y < height; ++y)
    {
        for(int x = 0; x < width; ++x)
        {
            // Create complex number c = x_start+ x*dx + (y_start+y*dy)i
            Complex c = Complex(x_start + (x*dx), y_start + (y*dy));

            // while |z| < 2 and we haven't reach max_its
            int iteration = mandelbrot(c, max_its);
            display_color(iteration);
        }
        printf("\n");
    }
}

std::string char_ = "\u2588";

std::string black = "\033[22;30m";
std::string red = "\033[22;31m";
std::string l_red = "\033[01;31m";
std::string green = "\033[22;32m";
std::string l_green = "\033[01;32m";
std::string orange = "\033[22;33m";
std::string yellow = "\033[01;33m";
std::string blue = "\033[22;34m";
std::string l_blue = "\033[01;34m";
std::string magenta = "\033[22;35m";
std::string l_magenta = "\033[01;35m";
std::string cyan = "\033[22;36m";
std::string l_cyan = "\033[01;36m";
std::string gray = "\033[22;37m";
std::string white = "\033[01;37m";

void display_color(double value) {
    if (value == 100) {std::cout << " ";}
    else if (value > 90) {std::cout << red << char_;}
    else if (value > 70) {std::cout << l_red << char_;}
    else if (value > 50) {std::cout << orange << char_;}
    else if (value > 30) {std::cout << yellow << char_;}
    else if (value > 20) {std::cout << l_green << char_;}
    else if (value > 10) {std::cout << green << char_;}
    else if (value > 5) {std::cout << l_cyan << char_;}
    else if (value > 4) {std::cout << white << char_;}
    else if (value > 3) {std::cout << l_blue << char_;}
    else if (value > 2) {std::cout << blue << char_;}
    else if (value > 1) {std::cout << black << char_;}
    else {std::cout << cyan << char_;}

    std::cout << "\033[0m";
}
