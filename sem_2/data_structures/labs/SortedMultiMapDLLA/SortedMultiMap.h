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

struct Link {
    int prev;
    int next;
};

constexpr int EMPTY_NODE = -1;
constexpr int INITIAL_CAPACITY = 8;

typedef Link* Plink;


using std::vector;

class SMMIterator;
typedef bool(*Relation)(TKey, TKey);


class SortedMultiMap {
	friend class SMMIterator;
    private:

    // the array of elements of pair
    TElem *elems;
    // the array of links prev and next
    Link* links;

    // the capacity of the array
    int cap;

    // the head and tail of the list
    int head;
    int tail;

    // the first empty position in the array
    int firstEmpty;

    // the size of the array
    int sz;

    // the relation
    Relation rl;

    int allocate();
	//dealoca spatiul de indice i
	void deallocate(int i);
	//functie privata care creeaza un nod in lista inlantuita
	int createNode(TElem e);

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
