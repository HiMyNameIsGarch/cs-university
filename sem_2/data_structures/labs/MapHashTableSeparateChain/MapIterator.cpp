#include "Map.h"
#include "MapIterator.h"
#include <stdexcept>

MapIterator::MapIterator(const Map& m) : map(m), currentBucket(0), currentNode(nullptr) {
    first();
}

void MapIterator::first() {
    currentBucket = 0;
    currentNode = nullptr;

    // Find the first valid node in the hashtable
    while (currentBucket < map.m_capacity) {
        if (map.m_hashtable[currentBucket].next != nullptr) {
            currentNode = map.m_hashtable[currentBucket].next;
            break;
        }
        currentBucket++;
    }
}

void MapIterator::next() {
    if (!valid()) {
        throw std::out_of_range("Iterator is not valid");
    }

    if (currentNode->next != nullptr) {
        // Move to the next node in the linked list
        currentNode = currentNode->next;
    } else {
        // Move to the next valid node in the hashtable
        currentBucket++;
        while (currentBucket < map.m_capacity) {
            if (map.m_hashtable[currentBucket].next != nullptr) {
                currentNode = map.m_hashtable[currentBucket].next;
                return;
            }
            currentBucket++;
        }
        // If no more valid nodes found, set currentNode to nullptr
        currentNode = nullptr;
    }
}

TElem MapIterator::getCurrent() const {
    if (!valid()) {
        throw std::out_of_range("Iterator is not valid");
    }

    return currentNode->element;
}

bool MapIterator::valid() const {
    return currentNode != nullptr;
}
