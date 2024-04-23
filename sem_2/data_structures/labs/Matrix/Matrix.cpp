#include "Matrix.h"
#include <stdexcept>

using std::get;

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

// Complexity:
// Best: T(sz)
// Worst: T(sz)
// Average: T(sz)
void Matrix::resize() {
    // Allocate a new array with double capacity or new capacity
    Position *new_array = new Position[MAX(this->cp * 2, this->maxCap)];
    // Check if the memory was allocated
    if (new_array == NULL) {
        delete [] this->array;
        throw std::bad_alloc();
    }

    // Copy the elements from the old array to the new array
    for(uint i = 0; i < this->sz; i++) {
        new_array[i] = array[i];
    }

    // Update the capacity of the array
    this->cp = MAX(this->cp * 2, this->maxCap);

    // Release the memory space occupied by the old array
    delete [] this->array;

    // Make the field e to refer the new array (with double capacity)
    this->array = new_array;
}

int Matrix::getFuturePosition(uint i, uint j) const {
    int left = 0;
    int right = this->sz - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        Position pos_mid = this->array[mid];
        int ci = get<0>(pos_mid);
        int cj = get<1>(pos_mid);

        if (ci == i && cj == j) {
            return mid;
        }
        else if (ci < i || (ci == i && cj < j)) {
            left = mid + 1;
        }
        else {
            right = mid - 1;
        }
    }
    return left;
}

// Time Complexity
// Best: T(1)
// Worst: T(log sz)
// Average: T(log sz)
int Matrix::searchAt(uint i, uint j) const {
    int left = 0;
    int right = this->sz - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        Position pos_mid = this->array[mid];
        int ci = get<0>(pos_mid);
        int cj = get<1>(pos_mid);

        if (ci == i && cj == j) {
            return mid;
        }
        else if (ci < i || (ci == i && cj < j)) {
            left = mid + 1;
        }
        else {
            right = mid - 1;
        }
    }
    return -1;
}


// Complexity:
// Best: T(1)
// Worst: T(log sz)
// Average: T(log sz)
TElem Matrix::element(uint i, uint j) const {
    // Check if the position (i, j) is valid
    if (i >= this->lines || j >= this->columns) {
        throw std::invalid_argument("i j is out of bounds");
    }

    // Check if the array is empty
    if (this->isEmpty()) {
        return NULL_TELEM;
    }

    // Search for the element at the position (i, j)
    int idx = searchAt(i, j);
    // If the element is not in the array
    if(idx < 0) {
        return NULL_TELEM;
    }

    // Get the element at the position (i, j)
    Position mid = this->array[idx];

    // Get the current element
    TElem current = get<2>(mid);
    return current;
}

TElem Matrix::deletePosition(int pos) {
    // Save the deleted element
    Position p = this->array[pos];
    TElem deletedElement = get<2>(p);

    // Shift all the position from a higher position to a lower one
    for(int k = pos; k < this->sz - 1; ++k) {
        this->array[k] = this->array[k + 1];
    }
    this->sz--;
    return deletedElement;
}

TElem Matrix::addPosition(uint i, uint j, TElem e) {
    // Determine the position at which the element should be placed
    int cpos = getFuturePosition(i, j);

    // We have the space to shift all the elements to the right
    for(int k = this->sz; k > cpos; --k) {
        this->array[k] = this->array[k - 1];
    }

    // All the elements are shifted now we have an empty entry where we
    // should put the new element
    this->array[cpos] = Position(i,j,e);
    sz++;
    return NULL_TELEM;
}

// Complexity:
// Best: T(1)
// Worst: T(cp)
// Average: T(log cp)
TElem Matrix::modify(uint i, uint j, TElem e) {
    // Check if the position (i, j) is valid
    if (i >= this->lines || j >= this->columns) {
        throw std::invalid_argument("i j is out of bounds");
    }

    // At this point we know for sure we have the capacity to add elements
    if(this->isEmpty()) {
        if(e == 0) {
            return NULL_TELEM;
        }
        this->array[0] = Position(i,j,e);
        this->sz++;
        return NULL_TELEM;
    }

    // Check if the array is full and resize it if necessary
    if(this->sz == this->cp) {
        this->resize();
    }

    // Get the element at some arbitrary i j position
    int pos = searchAt(i, j);

    // Delete operation
    if (e == 0)
        return deletePosition(pos);

    // Add operation
    if(pos < 0)
        return addPosition(i, j, e);

    // Modify operation
    Position current = this->array[pos];
    TElem old = get<2>(current);
    this->array[pos] = Position(i,j,e);
    return old;
}
