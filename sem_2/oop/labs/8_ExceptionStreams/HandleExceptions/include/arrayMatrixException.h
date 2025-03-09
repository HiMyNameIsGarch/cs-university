#pragma once
#ifndef ARRAYMATRIXEXCEPTION_H
#define ARRAYMATRIXEXCEPTION_H

class ArrayMatrixException {
public:
    ArrayMatrixException();
    ~ArrayMatrixException();
    virtual const char* what() const throw() = 0;

private:

};

#endif
