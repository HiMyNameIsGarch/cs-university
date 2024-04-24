#pragma once
#ifndef ROOK_H
#define ROOK_H
#include "chessPiece.h"

class Rook: public ChessPiece {

public:
    Rook(std::string color): ChessPiece("Rook", color, Position{0,0}) {};

    bool movePiece(Position newPosition);

};

#endif
