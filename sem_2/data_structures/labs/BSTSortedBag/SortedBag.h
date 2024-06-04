#pragma once
//DO NOT INCLUDE SORTEDBAGITERATOR

//DO NOT CHANGE THIS PART
typedef int TComp;
typedef TComp TElem;
typedef bool(*Relation)(TComp, TComp);
#define NULL_TCOMP -11111;

struct BSTNode {
    TElem element;
    int frequency;
    BSTNode* left;
    BSTNode* right;

    BSTNode(TElem elem, int freq) : element(elem), frequency(freq), left(nullptr), right(nullptr) {}
};

class SortedBagIterator;

class SortedBag {
	friend class SortedBagIterator;

private:
    // Representation
    BSTNode* root; // Pointer to the root of the BST
    Relation relation; // Function pointer for the relation

    // Private helper functions
    void recursiveAdd(BSTNode*& node, TElem e);
    bool recursiveRemove(BSTNode*& node, TElem e);
    BSTNode* findMin(BSTNode* node) const;
    bool recursiveSearch(BSTNode* node, TElem e) const;
    int recursiveNrOccurrences(BSTNode* node, TElem e) const;
    void deleteSubtree(BSTNode* node);
    int recursiveSize(BSTNode* node) const;

public:
	//constructor
	SortedBag(Relation r);

	//adds an element to the sorted bag
	void add(TComp e);

	//removes one occurence of an element from a sorted bag
	//returns true if an eleent was removed, false otherwise (if e was not part of the sorted bag)
	bool remove(TComp e);

	//checks if an element appearch is the sorted bag
	bool search(TComp e) const;

	//returns the number of occurrences for an element in the sorted bag
	int nrOccurrences(TComp e) const;

	//returns the number of elements from the sorted bag
	int size() const;

	//returns an iterator for this sorted bag
	SortedBagIterator iterator() const;

	//checks if the sorted bag is empty
	bool isEmpty() const;

	//destructor
	~SortedBag();
};
