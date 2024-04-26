#pragma once
#include "arrayMatrixException.h"
#ifndef INVALIDOPERATION_H
#define INVALIDOPERATION_H

class InvalidOperation: public ArrayMatrixException{
public:
    const char* what() const noexcept {
        return "Cannot apply the operation to the matrices!";
    }

};

#endif
