#include "Map.h"
#include "MapIterator.h"
#include <exception>
#include <stdexcept>
using namespace std;

// Constructor
MapIterator::MapIterator(const Map& m) : map(m) {
    currentPos = 0;
    // Find the first non-empty bucket
    while (currentPos < map.m_capacity && map.m_hashtable[currentPos].element == NULL_TELEM) {
        currentPos++;
    }
    if (currentPos < map.m_capacity) {
        currentNode = &map.m_hashtable[currentPos];
    } else {
        currentNode = nullptr;
    }
}

void MapIterator::first() {
    currentPos = 0;
    // Find the first non-empty bucket
    while (currentPos < map.m_capacity && map.m_hashtable[currentPos].element == NULL_TELEM) {
        currentPos++;
    }
    if (currentPos < map.m_capacity) {
        currentNode = &map.m_hashtable[currentPos];
    } else {
        currentNode = nullptr;
    }
}

void MapIterator::next() {
    if (!valid()) {
        throw std::runtime_error("Invalid iterator position.");
    }
    // Move to the next node in the linked list
    currentNode = currentNode->next;
    if (currentNode == nullptr) {
        // If the end of the linked list is reached, find the next non-empty bucket
        do {
            currentPos++;
        } while (currentPos < map.m_capacity && map.m_hashtable[currentPos].element == NULL_TELEM);
        if (currentPos < map.m_capacity) {
            currentNode = &map.m_hashtable[currentPos];
        } else {
            currentNode = nullptr;
        }
    }
}

TElem MapIterator::getCurrent() {
    if (!valid()) {
        throw std::runtime_error("Invalid iterator position.");
    }
    return currentNode->element;
}

bool MapIterator::valid() const {
    return currentNode != nullptr;
}
