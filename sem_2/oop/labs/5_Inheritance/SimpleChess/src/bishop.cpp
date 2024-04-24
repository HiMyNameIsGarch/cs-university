#include "../include/bishop.h"

bool Bishop::movePiece(Position newPosition) {
    if (abs(newPosition.x - position.x) == abs(newPosition.y - position.y)) {
        position = newPosition;
        return true;
    }
    return false;
}

