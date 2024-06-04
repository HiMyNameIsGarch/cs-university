#include "Map.h"
#include "MapIterator.h"

Map::Map() {
    m_capacity = 8;
    m_hashtable = new Node[m_capacity]();
    m_size = 0;
}

Map::~Map() {
    for (int i = 0; i < m_capacity; i++) {
        Node* current = m_hashtable[i].next;
        while (current != nullptr) {
            Node* temp = current;
            current = current->next;
            delete temp;
        }
    }
    delete[] m_hashtable;
}

int Map::hash(TKey key) const {
    // clear out the sign bit
    // basically this is the maximum value of signed 32 bit integer
    // so we can use it to get only the positive value of the key
    return key & 0x7FFFFFFF % m_capacity;
}

void Map::resize() {
    //resize of multimap
    int oldCapacity = m_capacity;
    Node* oldHashtable = m_hashtable;

    m_capacity *= 2;
    m_hashtable = new Node[m_capacity]();

    for (int i = 0; i < oldCapacity; i++) {
        Node* current = oldHashtable[i].next;
        while (current != nullptr) {
            Node* next = current->next;
            int position = hash(current->element.first);
            current->next = m_hashtable[position].next;
            m_hashtable[position].next = current;
            current = next;
        }
    }

    delete[] oldHashtable; //delete old hashtable
}

TValue Map::add(TKey c, TValue v) {
    if (m_size >= m_capacity / 2) {
        resize();
    }

    int position = hash(c);
    Node* current = m_hashtable[position].next;

    // Traverse the linked list to find the appropriate position to insert
    while (current != nullptr) {
        if (current->element.first == c) {
            // key already exists
            TValue oldValue = current->element.second;
            // replace the value
            current->element.second = v;
            return oldValue;
        }
        current = current->next;
    }

    // Key not found, add new node
    Node* newNode = new Node{std::make_pair(c, v), nullptr};
    newNode->next = m_hashtable[position].next;
    m_hashtable[position].next = newNode;
    m_size++;
    return NULL_TVALUE;
}

TValue Map::search(TKey c) const {
    int position = hash(c);
    Node* current = m_hashtable[position].next;

    // Traverse the linked list to find the key
    while (current != nullptr) {
        if (current->element.first == c) {
            return current->element.second;
        }
        current = current->next;
    }
    return NULL_TVALUE;
}

TValue Map::remove(TKey c) {
    int position = hash(c);
    Node* current = m_hashtable[position].next;
    Node* prev = nullptr;

    // Traverse the linked list to find the node with the key
    while (current != nullptr) {
        if (current->element.first == c) {
            // Found the node, remove it
            if (prev != nullptr) {
                prev->next = current->next;
            } else {
                m_hashtable[position].next = current->next;
            }
            TValue oldValue = current->element.second;
            delete current;
            m_size--;
            return oldValue;
        }
        prev = current;
        current = current->next;
    }

    return NULL_TVALUE; // Key not found
}

int Map::size() const {
    return m_size;
}

bool Map::isEmpty() const {
    return m_size == 0;
}

MapIterator Map::iterator() const {
	return MapIterator(*this);
}
