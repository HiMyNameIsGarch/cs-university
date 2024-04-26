#pragma once
#include <ostream>
#include "indexOutOfBounds.h"
#ifndef MATRIX_H
#define MATRIX_H
template <typename T>
class Matrix {
private:
    int rows;
    int cols;
    T** data;

public:
    Matrix<T>(int r, int c) {
        rows = r;
        cols = c;
        data = new T*[rows];
        if(data == nullptr)
            throw 1;
        // throw AllocationFailure();

        for (int i = 0; i < rows; i++) {
            data[i] = new T[cols];
            if(data[i] == nullptr)
                throw 1;
        }
    }

    // [] operator
    T* operator [] (int i) {
        if(i < 0 || i >= rows)
            throw IndexOutOfBounds(i, cols);
        return data[i];
    }
    // [][] operator
    T& operator () (int i, int j) {
        if(i < 0 || i >= rows || j < 0 || j >= cols)
            throw IndexOutOfBounds(j, cols);
        return data[i][j];
    }

    // addition
    Matrix<T> operator + (const Matrix<T> &m) {

        if(rows != m.rows || cols != m.cols) {
            throw 1;
        }
        Matrix<T> result(rows, cols);
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                result.data[i][j] = data[i][j] + m.data[i][j];
            }
        }
        return result;
    }

    friend std::istream& operator >> (std::istream& is, Matrix<T>& m) {
        for (int i = 0; i < m.rows; i++) {
            for (int j = 0; j < m.cols; j++) {
                is >> m.data[i][j];
            }
        }
        return is;
    }
};
#endif
