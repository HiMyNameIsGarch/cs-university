#include "../include/queen.h"

bool Queen::movePiece(Position newPosition) {
    if (newPosition.x == position.x || newPosition.y == position.y) {
        position = newPosition;
        return true;
    }
    if (abs(newPosition.x - position.x) == abs(newPosition.y - position.y)) {
        position = newPosition;
        return true;
    }
    return false;
}

