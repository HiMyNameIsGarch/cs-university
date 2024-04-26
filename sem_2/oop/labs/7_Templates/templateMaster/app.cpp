#include <iostream>
#include "include/pair.h"

template <class T> void swapValue(T &a, T &b) {
    T temp = a;
    a = b;
    b = temp;
}

template <typename T> T findMax(T &a, T &b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

int main() {
    // At least 2 data types for swapValue
    int a = 10, b = 20;
    swapValue(a, b);
    std::cout << "a: " << a << ", b: " << b << std::endl;
    double c = 1.2, d = 3.4;
    swapValue(c, d);
    std::cout << "c: " << c << ", d: " << d << std::endl;

    // At least 2 data types for findMax
    int e = 10, f = 20;
    std::cout << "Max: " << findMax(e, f) << std::endl;
    double g = 1.2, h = 3.4;
    std::cout << "Max: " << findMax(g, h) << std::endl;

    // Pair class
    Pair<int, double> pair(10, 1.2);
    std::cout << "First: " << pair.getFirst() << ", Second: " << pair.getSecond() << std::endl;
    pair.setFirst(20);
    pair.setSecond(3.4);
    std::cout << "First: " << pair.getFirst() << ", Second: " << pair.getSecond() << std::endl;
    return 0;
}

