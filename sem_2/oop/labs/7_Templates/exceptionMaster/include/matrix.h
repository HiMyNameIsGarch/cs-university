#pragma once
#include <ostream>
#include "indexOutOfBounds.h"
#ifndef MATRIX_H
#define MATRIX_H

template <typename T> class Matrix {
protected:

private:
    int rows;
    int cols;
    T** data;

public:
    Matrix<T>(int r, int c);

    friend std::istream& operator >> (std::istream& is, Matrix<T>& m);

    // [] operator
    T* operator [] (int i) {
        if(i < 0 || i >= rows)
            throw IndexOutOfBounds();
        return data[i];
    }
    // [][] operator
    T& operator () (int i, int j) {
        if(i < 0 || i >= rows || j < 0 || j >= cols)
            throw IndexOutOfBounds();
        return data[i][j];
    }

    // addition
    Matrix<T> operator + (const Matrix<T> &m);

};

#endif
