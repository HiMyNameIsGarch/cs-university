#include "../include/rook.h"

// movePiece
bool Rook::movePiece(Position newPosition) {
    if (newPosition.x == position.x || newPosition.y == position.y) {
        position = newPosition;
        return true;
    }
    return false;
}
