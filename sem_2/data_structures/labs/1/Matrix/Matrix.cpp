#include "Matrix.h"
#include <stdexcept>

Matrix::Matrix(uint nrLines, uint nrCols) {
    // Initialize the fields of the matrix
    this->lines = nrLines;
    this->columns = nrCols;
    this->maxCap = nrLines * nrCols;

    // Capacity and the size of the array
    this->cp = 1;
    this->sz = 0;

    // Allocate memory for the array
    this->array = new Position[this->cp];

    // Check if the memory was allocated
    if (this->array == NULL) {
        throw std::bad_alloc();
    }
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

bool Matrix::isEmpty() const {
    return this->sz == 0;
}

// magic formula ( not really )
// The formula is the index 'i' times the number of columns plus the index 'j'
// This computes the index of the element in the array at the position (i, j)
uint Matrix::getIndexAt(uint i, uint j) const {
    return i * nrColumns() + j;
}

void Matrix::resize() {
    // Allocate a new array with double capacity or new capacity
    Position *new_array = new Position[MAX(this->cp * 2, this->maxCap) + 1]; // +1 for the case when cp = 0
    // Check if the memory was allocated
    if (new_array == NULL) {
        delete [] this->array;
        throw std::bad_alloc();
    }

    // Copy the elements from the old array to the new array
    for(uint i = 0; i < this->cp; i++) {
        new_array[i] = array[i];
    }

    // Update the capacity of the array
    this->cp = MAX(this->cp * 2, this->maxCap);

    // Release the memory space occupied by the old array
    delete [] this->array;

    // Make the field e to refer the new array (with double capacity)
    this->array = new_array;
}

TElem Matrix::element(uint i, uint j) const {
    // Check if the position (i, j) is valid
    if (i < 0 || i >= this->lines) {
        throw std::invalid_argument("i is out of bounds");
    }
    if (j < 0 || j >= this->columns) {
        throw std::invalid_argument("j is out of bounds");
    }

    // Check if the array is empty
    if (this->isEmpty()) {
        return NULL_TELEM;
    }

    // Magic formula to get the current index
    int idx = getIndexAt(i, j);

    // Check if the position (i, j) is in the array
    if(this->cp < idx) {
        return NULL_TELEM;
    }

    // Get the element at the position (i, j)
    Position mid = this->array[idx];

    // Get the current element
    TElem current = std::get<2>(mid);
    return current;
}

TElem Matrix::modify(uint i, uint j, TElem e) {
    // Check if the position (i, j) is valid
    if (i < 0 || i >= this->lines) {
        throw std::invalid_argument("i is out of bounds");
    }
    if (j < 0 || j >= this->columns) {
        throw std::invalid_argument("j is out of bounds");
    }

    // Check if the array is full and resize it if necessary
    if(this->sz == this->cp) {
        this->resize();
    }

    int idx = getIndexAt(i,j);

    // Check if the position (i, j) is in the array and resize it if necessary
    while(this->cp < idx) {
        this->resize();
    }

    Position mid = this->array[idx];
    TElem old = std::get<2>(mid);

    // Check if the element at the position (i, j) already exists
    if(old != e) {
        this->sz++;
    }

    // Set the element at the position (i, j) to e
    this->array[idx] = Position(i,j,e);
    return old;
}
