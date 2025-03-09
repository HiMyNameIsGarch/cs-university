#pragma once
#include <string>
#ifndef INDEXOUTOFBOUNDS_H
#define INDEXOUTOFBOUNDS_H
#include "arrayMatrixException.h"

class IndexOutOfBounds: public ArrayMatrixException {
public:
    IndexOutOfBounds(const std::string& message);
    ~IndexOutOfBounds();
    virtual const char* what() const throw() {
        return message.c_str();
    }

private:

};

#endif
