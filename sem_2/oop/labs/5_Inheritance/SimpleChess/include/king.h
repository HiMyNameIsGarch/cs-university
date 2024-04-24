#pragma once
#ifndef KING_H
#define KING_H
#include "chessPiece.h"

class King: public ChessPiece {

public:
    King(std::string color);

    bool movePiece(Position newPosition);

};

#endif
