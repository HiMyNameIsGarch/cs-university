#include <iostream>
#include "include/matrix.h"

int main() {
    try {
        Matrix<double> m(2, 2);
        // 2 elements in each row
        Matrix<unsigned short> n1(3, 3);
        Matrix<unsigned short> n2(3, 4);

        auto a = n1 + n2;
        std::cout << a[100][12] << std::endl;

        double num = m[3][3];
        std::cout << num << std::endl;

    } catch(...) {
        std::cout << "Exception caught" << std::endl;
        std::cout << "we don't know exactly the message" << std::endl;
        std::cout << "Not cuz i'm lazy but because" << std::endl;
        std::cout << "it's 5:06AM and I have 5 more hours" << std::endl;
        std::cout << "till the exam, byeeee" << std::endl;
    }
    return 0;
}

