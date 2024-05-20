#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <stdexcept>
#include <vector>

using std::vector;
using std::make_pair;

SortedMultiMap::SortedMultiMap(Relation r) {
    rl = r;
    cap = 1;
    sz = 0;
    head = EMPTY_NODE;
    tail = EMPTY_NODE;
    firstEmpty = 0;
    nodes = new DLLANode[cap];
}

void SortedMultiMap::resize() {
    DLLANode *newNodes = new DLLANode[cap * 2];
    for (int i = 0; i < cap; i++) {
        newNodes[i] = nodes[i];
    }
    delete[] nodes;
    nodes = newNodes;
    cap *= 2;
}

int SortedMultiMap::allocateNode() {
    int newElemIdx = firstEmpty;
    if (newElemIdx != EMPTY_NODE) {
        firstEmpty = nodes[firstEmpty].next;
        if (firstEmpty != EMPTY_NODE) {
            nodes[firstEmpty].prev = EMPTY_NODE;
        }
        nodes[newElemIdx].next = EMPTY_NODE;
        nodes[newElemIdx].prev = EMPTY_NODE;
    }
    return newElemIdx;
}

int SortedMultiMap::freeNode(int pos) {
    nodes[pos].next = firstEmpty;
    nodes[pos].prev = EMPTY_NODE;
    if (firstEmpty != EMPTY_NODE) {
        nodes[firstEmpty].prev = pos;
    }
    firstEmpty = pos;
    return pos;
}

void SortedMultiMap::insertAtPos(TElem elem, int pos) {
    if(pos < 1 || pos > sz + 1) {
        throw std::invalid_argument("Invalid position");
    }

    int newElemIdx = allocateNode();
    if (newElemIdx == EMPTY_NODE) {
        resize();
        newElemIdx = allocateNode();
    }

    nodes[newElemIdx].info = elem;
    if (pos == 1) {
        if(head == EMPTY_NODE) {
            head = newElemIdx;
            tail = newElemIdx;
        } else {
            nodes[newElemIdx].next = head;
            nodes[head].prev = newElemIdx;
            head = newElemIdx;
        }
    } else {
        int currentIdx = head;
        int cPos = 1;
        while (currentIdx != EMPTY_NODE && cPos < pos - 1) {
            currentIdx = nodes[currentIdx].next;
            cPos++;
        }
        if (currentIdx != EMPTY_NODE) {
            int nextNode = nodes[currentIdx].next;
            nodes[newElemIdx].next = nextNode;
            nodes[newElemIdx].prev = currentIdx;
            nodes[currentIdx].next = newElemIdx;
            if (nextNode == EMPTY_NODE) {
                tail = newElemIdx;
            } else {
                nodes[nextNode].prev = newElemIdx;
            }
        }
    }
}

void SortedMultiMap::add(TKey c, TValue v) {
    // if the list is empty
    if (isEmpty()) {
        head = allocateNode();
        tail = head;
        nodes[head].info = make_pair(c, v);
        sz++;
        firstEmpty = head + 1;
        return;
    }
    // check if size is enough
    if (sz == cap) {
        resize();
    }
    // find the position to insert the new element
        // Find the position to insert the new element based on key
    int current = head;
    while (current != EMPTY_NODE && rl(nodes[current].info.first, c)) {
        current = nodes[current].next;
    }

    // Insert the new element at the found position
    insertAtPos(std::make_pair(c, v), current);
}

vector<TValue> SortedMultiMap::search(TKey c) const {
    vector<TValue> values = {};
    if (isEmpty() || c < 0) {
        return values;
    }
    int current = head;
    while (current != EMPTY_NODE) {
        if (nodes[current].info.first == c) {
            values.push_back(nodes[current].info.second);
        }
        current = nodes[current].next;
    }
	return values;
}

bool SortedMultiMap::remove(TKey c, TValue v) {
    if(isEmpty()) {
        return false;
    }
    int current = head;
    while (current != -1) {
        if (nodes[current].info.first == c && nodes[current].info.second == v) {
            if (current == head) {
                head = nodes[current].next;
                if (head != -1) {
                    nodes[head].prev = -1;
                }
            } else if (current == tail) {
                tail = nodes[current].prev;
                if (tail != -1) {
                    nodes[tail].next = -1;
                }
            } else {
                nodes[nodes[current].prev].next = nodes[current].next;
                nodes[nodes[current].next].prev = nodes[current].prev;
            }
            freeNode(current);
            sz--;
            return true;
        }
        current = nodes[current].next;
    }
    return false;
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
    delete[] nodes;
}
