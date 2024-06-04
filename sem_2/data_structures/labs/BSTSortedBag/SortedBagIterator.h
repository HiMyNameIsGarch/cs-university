#pragma once
#include "SortedBag.h"
#include <stack>
using namespace std;

class SortedBag;

class SortedBagIterator
{
	friend class SortedBag;

private:
	const SortedBag& bag;
	SortedBagIterator(const SortedBag& b);
	BSTNode* current; // Pointer to the current node in the binary search tree
    std::stack<BSTNode*> stack; // Stack to keep track of the path to the current node

	// Private helper function to find the minimum node in a subtree
	BSTNode* findMinNode(BSTNode* node) const;
    void initializeStack();


public:
	TComp getCurrent();
	bool valid();
	void next();
	void first();
};

