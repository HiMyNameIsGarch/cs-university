#pragma once
#ifndef ARRAYMATRIXEXCEPTION_H
#define ARRAYMATRIXEXCEPTION_H

class ArrayMatrixException {
public:
    virtual const char* what() const {
        return "Array Matrix Exception thrown!";
    }

};

#endif
