#pragma once

//DO NOT CHANGE THIS PART
typedef int TElem;
#define NULL_TELEM 0
typedef unsigned int uint;

// max of 2 numbers ( used in the resize function )
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

#include <utility>
typedef std::tuple<uint, uint, TElem> Position;

//DO NOT CHANGE THIS PART
class Matrix {

private:
    // The array of positions
    Position *array;

    // The capacity of the array
    uint cp;

    // The size of the array
    uint sz;

    // The number of lines and columns
    uint lines;
    uint columns;

    // Maximum capacity, computed in the constructor
    uint maxCap;

    // Get the index of the position (i, j) in the array
    uint getIndexAt(uint i, uint j) const;

    // Resize the array
    void resize();

public:
	//constructor
	Matrix(uint nrLines, uint nrCols);

    // Destructor
    ~Matrix();

	//returns the number of lines
	uint nrLines() const;

	//returns the number of columns
	uint nrColumns() const;

	//returns the element from line i and column j (indexing starts from 0)
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem element(uint i, uint j) const;

	//modifies the value from line i and column j
	//returns the previous value from the position
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem modify(uint i, uint j, TElem e);

};
