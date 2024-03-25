#include "Matrix.h"
#include <stdexcept>
#include <tuple>

Matrix::Matrix(int nrLines, int nrCols) {

    this->lines = nrLines;
    this->columns = nrCols;
    this->cp = 1;
    this->sz = 0;

    this->array = (Position *)malloc(sizeof(Position) * this->cp);
    if (this->array == NULL) {
        throw std::bad_alloc();
    }

    // int c = 0;
    // for(int i = 0; i < nrLines; i++) {
    //     for(int j = 0; j < nrCols; j++) {
    //         Position p = std::make_tuple(i, j, NULL_TELEM);
    //         this->array[c] = p;
    //         c++;
    //     }
    // }
}

Matrix::~Matrix() {
    free(this->array);
}

int Matrix::nrLines() const {
    return this->lines;
}

int Matrix::nrColumns() const {
	return this->columns;
}

void Matrix::resize() {
    this->cp += 1;
    Position *new_array = (Position *)realloc(this->array, sizeof(Position) * this->cp);

    if (new_array == NULL) {
        free(this->array);
        throw std::bad_alloc();
    }
    else {
        this->array = new_array;
    }
}

int Matrix::searchAt(int i, int j) const {
    int low = 0;
    int high = this->sz;
    while (low <= high) {
        int mid = (low + high) / 2;
        Position pos_mid = this->array[mid];
        int ci = std::get<0>(pos_mid);
        int cj = std::get<1>(pos_mid);

        if (ci == i && cj == j) {
            return std::get<2>(pos_mid);
        }
        else if (ci < i || (ci == i && cj < j)) {
            low = mid + 1;
        }
        else {
            high = mid - 1;
        }
    }
    return NULL_TELEM;
}

TElem Matrix::element(int i, int j) const {
    if (i < 0 || i >= this->lines) {
        throw std::invalid_argument("i is out of bounds");
    }
    if (j < 0 || j >= this->columns) {
        throw std::invalid_argument("j is out of bounds");
    }

    int low = 0;
    int high = this->sz;
    while (low <= high) {
        int mid = (low + high) / 2;
        Position pos_mid = this->array[mid];
        int ci = std::get<0>(pos_mid);
        int cj = std::get<1>(pos_mid);

        if (ci == i && cj == j) {
            return std::get<2>(pos_mid);
        }
        else if (ci < i || (ci == i && cj < j)) {
            low = mid + 1;
        }
        else {
            high = mid - 1;
        }
    }
    return NULL_TELEM;
}

TElem Matrix::modify(int i, int j, TElem e) {
    if (i < 0 || i >= this->lines) {
        throw std::invalid_argument("i is out of bounds");
    }
    if (j < 0 || j >= this->columns) {
        throw std::invalid_argument("j is out of bounds");
    }

    if(this->sz == this->cp) {
        this->resize();
    }

    int low = 0;
    int high = this->sz;
    while (low <= high) {
        int mid = (low + high) / 2;
        Position pos_mid = this->array[mid];
        int ci = std::get<0>(pos_mid);
        int cj = std::get<1>(pos_mid);

        if (ci == i && cj == j) {
            TElem old = std::get<2>(pos_mid);
            this->array[mid] = Position(i,j,e);
            return old;
        }
        else if (ci < i || (ci == i && cj < j)) {
            low = mid + 1;
        }
        else {
            high = mid - 1;
        }
    }

	return NULL_TELEM;
}
