#include "Map.h"
#include "MapIterator.h"
#include <exception>
using namespace std;


MapIterator::MapIterator(const Map& d) : map(d)
{
    first();
}


void MapIterator::first() {
    current = 0;
    while (current < map.m_capacity && !map.m_hashtable[current].valid) {
        current++;
    }
}


void MapIterator::next() {
    if (!valid()) {
        throw exception();
    }

    current++;
    while (current < map.m_capacity && !map.m_hashtable[current].valid) {
        current++;
    }
}


TElem MapIterator::getCurrent(){
    if (!valid()) {
        throw exception();
    }

    // return the current element from the iterator
    return map.m_hashtable[current].element;
}


bool MapIterator::valid() const {
    return map.size() > 0 && current < map.m_capacity;
}
