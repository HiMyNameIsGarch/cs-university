#include "../include/chessPiece.h"

ChessPiece::ChessPiece(std::string name, std::string color, Position position) {
    this->name = name;
    this->color = color;
    this->position = position;
}

