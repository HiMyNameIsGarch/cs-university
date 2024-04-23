#include "Matrix.h"
#include "ShortTest.h"
#include "ExtendedTest.h"
// #include <iostream>

int main() {

    // Short tests
    // Matrix m = Matrix(5, 5);
    // m.modify(1, 2, 3);
    // m.modify(1, 4, 4);
    // m.modify(0, 1, 5);
    // m.modify(1, 3, 4);
    // m.modify(2, 2, 3);
    testAll();
    testAllExtended();
    return 0;
}
