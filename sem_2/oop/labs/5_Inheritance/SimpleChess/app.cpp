#include <iostream>
#include "include/king.h"

int main() {
    King king("white");
    std::cout << king.movePiece(Position{0, 1}) << std::endl;
    std::cout << king.movePiece(Position{1, 1}) << std::endl;
    std::cout << king.movePiece(Position{1, 0}) << std::endl;
    std::cout << king.movePiece(Position{1, -1}) << std::endl;
    std::cout << king.movePiece(Position{0, -1}) << std::endl;
    std::cout << king.movePiece(Position{-1, -1}) << std::endl;
    std::cout << king.movePiece(Position{-1, 0}) << std::endl;
    std::cout << king.movePiece(Position{-1, 1}) << std::endl;
    return 0;
}

