#include "SMIterator.h"
#include "SortedMap.h"
#include <exception>
using namespace std;

SortedMap::SortedMap(Relation r) {
    relation = r;
    head = NULL;
    length = 0;
}

TValue SortedMap::add(TKey k, TValue v) {
        // Create the new pair
    std::pair<TKey, TValue> pair = make_pair(k,v);

    // Check if the list is empty
    if (head == NULL) {
        // If the list is empty, add the new pair as the head
        Node *newNode = new Node();
        newNode->elem = pair;
        newNode->next = NULL;
        head = newNode;
        length++;
        return NULL_TVALUE; // New pair added, return null value
    }

    Node *currentNode = head;
    Node *prevNode = NULL;

    // Traverse the list to find the appropriate position for the new pair
    while (currentNode != NULL && !relation(k, currentNode->elem.first)) {
        prevNode = currentNode;
        currentNode = currentNode->next;
    }

    // Check if the key already exists in the map
    if (currentNode != NULL && currentNode->elem.first == k) {
        // Key already exists, replace the old value with the new value
        TValue oldValue = currentNode->elem.second;
        currentNode->elem.second = v;
        return oldValue; // Return the old value
    } else {
        // Key does not exist, add the new pair
        Node *newNode = new Node();
        newNode->elem = pair;
        newNode->next = currentNode;

        // Adjust pointers to insert the new node
        if (prevNode == NULL) {
            // The new pair should be the new head
            head = newNode;
        } else {
            prevNode->next = newNode;
        }

        length++;
        return NULL_TVALUE; // New pair added, return null value
    }
}

TValue SortedMap::search(TKey k) const {
    // Check if the list is empty
    if(isEmpty()) {
        return NULL_TVALUE;
    }
    // Use the iterator to find the key
    SMIterator it = iterator();
    // Get the current node
    it.first();
    // Traverse the list to find the key
    while(it.valid()) {
        // Check if the key was found
        if(it.getCurrent().first == k) {
            return it.getCurrent().second;
        }
        // Move to the next node
        it.next();
    }
    return NULL_TVALUE;
}

TValue SortedMap::remove(TKey k) {
    // Check if the list is empty
    if(isEmpty()) {
        return NULL_TVALUE;
    }

    // Check if the head should be removed
    Node *currentNode = head;
    if(relation(k, head->elem.first)) {
        // Check if the key was not found
        if(head->elem.first != k) {
            return NULL_TVALUE;
        }
        // Remove the head
        head = head->next;
        // Save the value to be returned
        TValue deleted = currentNode->elem.second;
        // Delete the node
        delete currentNode;
        // Decrement the length and check if the list is empty
        if (length-- == 0)
            head = NULL;
        // Finally return the deleted value
        return deleted;
    }

    // Traverse the list to find the node to be deleted based on the relation
    while(currentNode->next != NULL && !relation(k, currentNode->next->elem.first)) {
        currentNode = currentNode->next;
    }

    // Take the node to be deleted
    Node *toDelete = currentNode->next;

    // Check if the key was not found
    if(toDelete == NULL || toDelete->elem.first != k) {
        return NULL_TVALUE;
    }

    // Remove the node
    currentNode->next = toDelete->next;
    // Save the value to be returned
    TValue deleted = toDelete->elem.second;
    // Delete the node
    delete toDelete;

    // Decrement the length and check if the list is empty
    if (length-- == 0)
        head = NULL;

    // Finally return the deleted value
    return deleted;
}

int SortedMap::size() const {
    return length;
}

bool SortedMap::isEmpty() const {
    return length == 0 && head == NULL;
}

SMIterator SortedMap::iterator() const {
	return SMIterator(*this);
}

SortedMap::~SortedMap() {
    Node* current = head;
    while(current != NULL) {
        Node* next = current->next;
        delete current;
        current = next;
    }
    head = NULL;
    length = 0;
}
