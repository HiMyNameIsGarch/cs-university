#include "Map.h"
#include "MapIterator.h"

Map::Map() {
    // Initialize capacity, hash table, and size
    m_capacity = INITIAL_CAPACITY; // Define your initial capacity
    m_hashtable = new Node[m_capacity]();
    for (int i = 0; i < m_capacity; ++i) {
        m_hashtable[i].next = nullptr;
        m_hashtable[i].element = NULL_TELEM;
    }
    m_size = 0;
}

Map::~Map() {
    // // Delete all nodes and the hash table array
    // for (int i = 0; i < m_capacity; ++i) {
    //     Node* current = &m_hashtable[i];
    //     while (current->next != nullptr) {
    //         Node* next = current->next;
    //         delete current; // Delete only the node, not the entire structure
    //         current = next;
    //     }
    // }
    delete[] m_hashtable;
}

int Map::hash(TKey key) const {
    const int prime = 31; // A prime number for better distribution
    int hashValue = 13;

    // Use prime number multiplication and bitwise shifting
    hashValue = (hashValue * prime) + (key ^ (key >> 16));

    // Ensure the hash value is non-negative
    // hashValue &= 0x7FFFFFFF;

    return hashValue % m_capacity;

}

void Map::resize() {
    // Allocate a new hash table with a larger capacity
    int newCapacity = m_capacity * 2; // or use any other resizing strategy
    Node** newTable = new Node*[newCapacity];
    for (int i = 0; i < newCapacity; ++i) {
        newTable[i] = nullptr;
    }

    // Rehash all elements into the new table
    for (int i = 0; i < m_capacity; ++i) {
        Node* current = &m_hashtable[i];
        while (current != nullptr) {
            TKey key = current->element.first;
            int hashValue = hash(key);
            Node* newNode = new Node{ current->element, newTable[hashValue] };
            newTable[hashValue] = newNode;
            current = current->next;
        }
    }

    // Update the hash table and capacity
    delete[] m_hashtable;
    m_hashtable = *newTable;
    m_capacity = newCapacity;
}

TValue Map::add(TKey c, TValue v){
    // Check if resize is needed
    if (m_size > m_capacity * 2) {
        resize();
    }

    int hashValue = hash(c);
    Node* current = &m_hashtable[hashValue];

    // Search for the key in the chain
    while (current != nullptr) {
        // if the key is already in the map, add the value to the linked list
        if (current->element.first == c) {
            // Key found, add the new value to the end of the linked list
            Node* newNode = new Node{ std::make_pair(c, v), nullptr };
            Node* temp = current;
            while (temp->next != nullptr) {
                temp = temp->next;
            }
            temp->next = newNode;
            return current->element.second;
        }
        current = current->next;
    }

    // If key not found, add a new node to the chain
    Node* newNode = new Node{ std::make_pair(c, v), nullptr };
    if (m_hashtable[hashValue].next == nullptr) {
        m_hashtable[hashValue] = *newNode;
    } else {
        newNode->next = m_hashtable[hashValue].next;
        m_hashtable[hashValue].next = newNode;
    }
    ++m_size;

    return NULL_TVALUE;
}

TValue Map::search(TKey c) const{
    int hashValue = hash(c);
    Node* current = &m_hashtable[hashValue];

    // Search for the key in the chain
    while (current != nullptr) {
        if (current->element.first == c) {
            // Key found, traverse the linked list to find the last value
            Node* temp = current;
            while (temp->next != nullptr) {
                temp = temp->next;
            }
            return temp->element.second;
        }
        current = current->next;
    }

    // Key not found, return NULL_TVALUE
    return NULL_TVALUE;
}

TValue Map::remove(TKey c){
        int hashValue = hash(c);
    Node* current = &m_hashtable[hashValue];
    Node* previous = nullptr;

    // Search for the key in the chain
    while (current != nullptr) {
        if (current->element.first == c) {
            // Key found, traverse the linked list to find the last node
            Node* temp = current;
            while (temp->next != nullptr) {
                temp = temp->next;
            }

            // Remove the node from the array
            if (previous != nullptr) {
                previous->next = current->next;
            } else {
                m_hashtable[hashValue] = *current->next;
            }

            // Disconnect the node from the linked list
            current->next = nullptr;
            --m_size;
            return temp->element.second;
        }
        previous = current;
        current = current->next;
    }

    // Key not found, return NULL_TVALUE
    return NULL_TVALUE;
}


int Map::size() const {
    return m_size;
}

bool Map::isEmpty() const{
    return m_size == 0;
}

MapIterator Map::iterator() const {
	return MapIterator(*this);
}
