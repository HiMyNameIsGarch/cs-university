#include "../include/king.h"


// Constructor
King::King(std::string color) : ChessPiece("King", color, Position{0,0}) {
    name = "King";
}

// movePiece
bool King::movePiece(Position newPosition) {
    Position np = newPosition;
    Position cp = position;
    if (np.x == cp.x && (np.y == cp.y + 1 || np.y == cp.y - 1)) {
        cp = np;
        return true;
    }
    if (np.x == cp.x + 1 && (np.y == cp.y + 1 || np.y == cp.y - 1 || np.y == cp.y)) {
        cp = np;
        return true;
    }
    if (np.x == cp.x - 1 && (np.y == cp.y + 1 || np.y == cp.y - 1 || np.y == cp.y)) {
        cp = np;
        return true;
    }
    return false;
}
