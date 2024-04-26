#pragma once
#include "arrayMatrixException.h"
#ifndef INDEXOUTOFBOUNDS_H
#define INDEXOUTOFBOUNDS_H

class IndexOutOfBounds: public ArrayMatrixException{
public:
    const char* what() const noexcept {
        return "Index out of bounds, invalid attempt to access an element outside of the range of the matrix!";
    }

};

#endif
