#pragma once
#include "arrayMatrixException.h"
#ifndef INDEXOUTOFBOUNDS_H
#define INDEXOUTOFBOUNDS_H

class IndexOutOfBounds: public ArrayMatrixException{
private:
    int cidx;
    int ridx;

public:
    IndexOutOfBounds(int cidx, int ridx);
    const char* what() const noexcept;

};

#endif
