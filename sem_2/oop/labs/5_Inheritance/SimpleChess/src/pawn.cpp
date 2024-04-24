#include "../include/pawn.h"

bool Pawn::movePiece(Position newPos) {
    if (newPos.x == position.x && newPos.y == position.y + 1) {
        position = newPos;
        return true;
    }
    return false;
}
