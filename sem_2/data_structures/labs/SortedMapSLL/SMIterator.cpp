#include "SMIterator.h"
#include "SortedMap.h"
#include <exception>

using namespace std;

SMIterator::SMIterator(const SortedMap& m) : map(m){
    current = map.head;
}

void SMIterator::first(){
    current = map.head;
}

void SMIterator::next(){
    if(!valid()) {
        throw exception();
    }
    current = current->next;
}

bool SMIterator::valid() const{
	return current != NULL;
}

TElem SMIterator::getCurrent() const{
    if(!valid()) {
        throw exception();
    }
	return current->elem;
}

