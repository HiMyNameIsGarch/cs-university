#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <stdexcept>
#include <vector>

using std::vector;
using std::make_pair;

SortedMultiMap::SortedMultiMap(Relation r) {
    rl = r;
    cap = INITIAL_CAPACITY;
    sz = 0;
    head = EMPTY_NODE;
    tail = EMPTY_NODE;

    // allocate the arrays
    elems = new TElem[cap];
    links = new Link[cap];

    // initialize the links
    for(int i = 0; i < cap - 1; i++) {
        links[i].next = i + 1;
        links[i].prev = EMPTY_NODE;
    }

    links[cap - 1].next = EMPTY_NODE;
    firstEmpty = 0;
}

int SortedMultiMap::createNode(TElem e) {
    int i = allocate();
    if(i != EMPTY_NODE) {
        elems[i] = e;
    }
    return i;
}

int SortedMultiMap::allocate() {
    // if the array is full, resize it
    if(firstEmpty == EMPTY_NODE) {
        cap *= 2;
        TElem *newElems = new TElem[cap];
        Link *newLinks = new Link[cap];

        for(int i = 0; i < cap / 2; i++) {
            newElems[i] = elems[i];
            newLinks[i] = links[i];
        }

        for(int i = cap / 2; i < cap - 1; i++) {
            newLinks[i].next = i + 1;
            newLinks[i].prev = EMPTY_NODE;
        }

        newLinks[cap - 1].next = EMPTY_NODE;
        firstEmpty = cap / 2;

        delete[] elems;
        delete[] links;

        elems = newElems;
        links = newLinks;
    }

    // get the first empty position
    int i = firstEmpty;
    firstEmpty = links[firstEmpty].next;
    return i;
}

// deallocate the space of index i
void SortedMultiMap::deallocate(int i) {
    links[i].next = firstEmpty;
    links[i].prev = EMPTY_NODE;
    firstEmpty = i;
}

//adds a new key value pair to the sorted multi map
void SortedMultiMap::add(TKey c, TValue v) {
    int i = createNode(make_pair(c,v));
    // take into accout the relation
    if (i != EMPTY_NODE){
        links[i].next = head;
        links[i].prev = -1;
        if (head != EMPTY_NODE) {
            links[head].prev = i;
        } else {
            tail = i; // If the list was empty, set tail to i
        }
        head = i;
    }
    sz += 1;
}

//returns the values belonging to a given key
vector<TValue> SortedMultiMap::search(TKey c) const {
    vector<TValue> values;
    int current = head;
    while(current != EMPTY_NODE) {
        if(elems[current].first == c) {
            values.push_back(elems[current].second);
        }
        current = links[current].next;
    }
    return values;
}

//removes a key value pair from the sorted multimap
//returns true if the pair was removed (it was part of the multimap), false if nothing is removed
bool SortedMultiMap::remove(TKey c, TValue v) {
    bool found = false;
    int current = head;
    int prev = -1;
    while (current != EMPTY_NODE && !found) {
        if (elems[current].first == c && elems[current].second == v) {
            found = true;
        } else {
            prev = current;
            current = links[current].next;
        }
    }
    if (!found) {
        return false;
    } else {
        // We have to remove the element at index current
        if (prev == -1) {
            head = links[head].next;
        } else {
            links[prev].next = links[current].next;
        }
        if (current == tail) {
            tail = prev;
        } else {
            links[links[current].next].prev = prev;
        }
        deallocate(current);
        sz -= 1;
        return true;
    }
}


int SortedMultiMap::size() const {
    return sz;
}

bool SortedMultiMap::isEmpty() const {
    return sz == 0 || head == -1 || tail == -1;
}

SMMIterator SortedMultiMap::iterator() const {
	return SMMIterator(*this);
}

SortedMultiMap::~SortedMultiMap() {
    delete[] links;
    delete[] elems;
}
