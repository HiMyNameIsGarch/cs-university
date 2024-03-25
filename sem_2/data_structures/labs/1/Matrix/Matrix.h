#pragma once

//DO NOT CHANGE THIS PART
typedef int TElem;
#define NULL_TELEM 0

#include <utility>
typedef std::tuple<int, int, TElem> Position;
/*
Example:
[
    <1,1,1>
    <1,2,2>
    <2,1,3>
    <2,2,4>
]
*/

class Matrix {

private:
    // The array of positions
    Position *array;

    // The capacity of the array
    unsigned int cp;

    // The size of the array
    unsigned int sz;

    // The number of lines and columns
    unsigned int lines;
    unsigned int columns;

    int searchAt(int i, int j) const;

    void resize();

public:
	//constructor
	Matrix(int nrLines, int nrCols);

    ~Matrix();

	//returns the number of lines
	int nrLines() const;

	//returns the number of columns
	int nrColumns() const;

	//returns the element from line i and column j (indexing starts from 0)
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem element(int i, int j) const;

	//modifies the value from line i and column j
	//returns the previous value from the position
	//throws exception if (i,j) is not a valid position in the Matrix
	TElem modify(int i, int j, TElem e);

};
