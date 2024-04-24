#pragma once
#ifndef BISHOP_H
#define BISHOP_H
#include "chessPiece.h"

class Bishop : public ChessPiece {

public:
    Bishop(std::string color);

    bool movePiece(Position newPosition);

};

#endif
