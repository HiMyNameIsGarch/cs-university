#include "SMMIterator.h"
#include "SortedMultiMap.h"

SMMIterator::SMMIterator(const SortedMultiMap& d) : map(d){
    current = d.head;
}

void SMMIterator::first(){
    current = map.head;
}

// Complexity: Theta(1)
void SMMIterator::next(){
    if(!valid()) {
        throw std::exception();
    }
    current = map.nodes[current].next;
}

// Complexity: Theta(1)
bool SMMIterator::valid() const{
    return current != EMPTY_NODE;
}

// Complexity: Theta(1)
TElem SMMIterator::getCurrent() const{
    if(!valid()) {
        throw std::exception();
    }
    return map.nodes[current].info;
}


