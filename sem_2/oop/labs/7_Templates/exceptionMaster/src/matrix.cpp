#include "../include/matrix.h"
#include "../include/invalidOperation.h"
#include "../include/allocationFailure.h"


// Constructor
template <typename T>
Matrix<T>::Matrix(int r, int c): rows(r), cols(c) {
    data = new int*[rows];
    if(data == nullptr)
        throw AllocationFailure();

    for (int i = 0; i < rows; i++) {
        data[i] = new int[cols];
        if(data[i] == nullptr)
            throw AllocationFailure();
    }
}

template <typename T>
std::istream& operator >> (std::istream& is, Matrix<T>& m) {
    for (int i = 0; i < m.rows; i++) {
        for (int j = 0; j < m.cols; j++) {
            is >> m.data[i][j];
        }
    }
    return is;
}

// addition
template <typename T>
Matrix<T> Matrix<T>::operator + (const Matrix<T> &m) {
    if(rows != m.rows || cols != m.cols) {
        throw InvalidOperation();
    }
    Matrix<T> result(rows, cols);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result.data[i][j] = data[i][j] + m.data[i][j];
        }
    }
    return result;
}
