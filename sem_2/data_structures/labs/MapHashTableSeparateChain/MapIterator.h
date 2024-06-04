#pragma once
#include "Map.h"

class MapIterator
{
	//DO NOT CHANGE THIS PART
	friend class Map;

private:
	const Map& map;
    int currentBucket;  // Current bucket in the hashtable
    Node* currentNode;  // Current node in the linked list

	MapIterator(const Map& m);

public:
	void first();
	void next();
	TElem getCurrent() const;
	bool valid() const;
};
