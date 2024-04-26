#pragma once
#include "arrayMatrixException.h"
#ifndef ALLOCATIONFAILURE_H
#define ALLOCATIONFAILURE_H

class AllocationFailure: public ArrayMatrixException {
public:
    const char* what() const noexcept {
        return "Cannot allocate memory for the matrix!";
    }

};

#endif
