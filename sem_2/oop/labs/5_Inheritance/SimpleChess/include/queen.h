#pragma once
#ifndef QUEEN_H
#define QUEEN_H
#include "chessPiece.h"

class Queen : public ChessPiece {

public:
    Queen(std::string color);

    bool movePiece(Position newPosition);

};

#endif
