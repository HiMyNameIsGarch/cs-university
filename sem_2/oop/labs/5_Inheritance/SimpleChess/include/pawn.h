#pragma once
#ifndef PAWN_H
#define PAWN_H
#include "chessPiece.h"

class Pawn: public ChessPiece {

public:
    Pawn(std::string color) : ChessPiece("Pawn", color, Position{0,0}) {};

    bool movePiece(Position newPosition);

};

#endif
