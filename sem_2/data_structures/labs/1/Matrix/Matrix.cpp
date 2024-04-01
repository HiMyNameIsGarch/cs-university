#include "Matrix.h"
#include <stdexcept>

Matrix::Matrix(uint nrLines, uint nrCols) {
    this->lines = nrLines;
    this->columns = nrCols;
    this->maxCap = nrLines * nrCols;
    this->cp = 1;

    this->array = new Position[this->cp];

    if (this->array == NULL) {
        throw std::bad_alloc();
    }

    this->sz = 0;
}

Matrix::~Matrix() {
    delete [] this->array;
}

uint Matrix::nrLines() const {
    return this->lines;
}

uint Matrix::nrColumns() const {
	return this->columns;
}

void Matrix::resize() {
    // Allocate a new array with double capacity or new capacity
    Position *new_array = new Position[MAX(this->cp * 2, this->maxCap) + 1]; // +1 for the case when cp = 0
    if (new_array == NULL) {
        delete [] this->array;
        throw std::bad_alloc();
    }

    // Copy the elements from the old array to the new array
    for(uint i = 0; i < this->cp; i++) {
        new_array[i] = array[i];
    }
    this-> cp = MAX(this->cp * 2, this->maxCap);

    // Release the memory space occupied by the old array
    delete [] this->array;

    // Make the field e to refer the new array (with double capacity)
    this->array = new_array;
}

TElem Matrix::element(uint i, uint j) const {
    if (i < 0 || i >= this->lines) {
        throw std::invalid_argument("i is out of bounds");
    }
    if (j < 0 || j >= this->columns) {
        throw std::invalid_argument("j is out of bounds");
    }

    int iab = i * nrColumns() + j;

    if(this->cp < iab) {
        return NULL_TELEM;
    }

    Position mid = this->array[iab];

    TElem current = std::get<2>(mid);
    return current;
}

TElem Matrix::modify(uint i, uint j, TElem e) {
    if (i < 0 || i >= this->lines) {
        throw std::invalid_argument("i is out of bounds");
    }
    if (j < 0 || j >= this->columns) {
        throw std::invalid_argument("j is out of bounds");
    }

    if(this->sz == this->cp) {
        this->resize();
    }

    // magic formula ( not really )
    // The formula is the index 'i' times the number of columns plus the index 'j'
    // This computes the index of the element in the array at the position (i, j)
    int iab = i * nrColumns() + j;

    while(this->cp < iab) {
        this->resize();
    }

    Position mid = this->array[iab];

    TElem old = std::get<2>(mid);

    if(old != e) {
        this->sz++;
    }
    this->array[iab] = Position(i,j,e);
    return old;

	return NULL_TELEM;
}
