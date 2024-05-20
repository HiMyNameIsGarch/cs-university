#pragma once
//DO NOT INCLUDE SMMITERATOR

//DO NOT CHANGE THIS PART
#include <vector>
#include <utility>

// Custom Types
typedef int TKey;
typedef int TValue;
typedef std::pair<TKey, TValue> TElem;
// NULL values
#define NULL_TVALUE -111111
#define NULL_TELEM pair<TKey, TValue>(-111111, -111111);
#define EMPTY_NODE -1

struct DLLANode {
    TElem info;
    int next;
    int prev;
};

using std::vector;

class SMMIterator;
typedef bool(*Relation)(TKey, TKey);

class SortedMultiMap {
	friend class SMMIterator;
    private:
		//TODO - Representation
    DLLANode *nodes;
    int cap;
    int head;
    int tail;
    int firstEmpty;
    int sz;
    Relation rl;

    // functions
    int allocateNode();
    // return the position was freed
    int freeNode(int pos);
    // resize the array of nodes
    void resize();
    // insert elem at a given position
    void insertAtPos(TElem elem, int pos);

    public:

    // constructor
    SortedMultiMap(Relation r);

	//adds a new key value pair to the sorted multi map
    void add(TKey c, TValue v);

	//returns the values belonging to a given key
    vector<TValue> search(TKey c) const;

	//removes a key value pair from the sorted multimap
	//returns true if the pair was removed (it was part of the multimap), false if nothing is removed
    bool remove(TKey c, TValue v);

    //returns the number of key-value pairs from the sorted multimap
    int size() const;

    //verifies if the sorted multi map is empty
    bool isEmpty() const;

    // returns an iterator for the sorted multimap. The iterator will returns the pairs as required by the relation (given to the constructor)
    SMMIterator iterator() const;

    // destructor
    ~SortedMultiMap();
};
