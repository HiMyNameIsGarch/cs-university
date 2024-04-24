#pragma once
#ifndef CHESSPIECE_H
#define CHESSPIECE_H
#include <iostream>

struct Position {
    int x: 3;
    int y: 3;
};

class ChessPiece {

protected:
    Position position;

    std::string name;

private:
    std::string color;

public:
    bool movePiece(Position newPosition);

    ChessPiece();

    ChessPiece(std::string name, std::string color, Position position);
};

#endif
