#include "Map.h"
#include "MapIterator.h"

Map::Map() {
    m_capacity = 8;
    m_hashtable = new Node[m_capacity]();
    m_size = 0;
}

Map::~Map() {
    delete [] m_hashtable;
}

int Map::hash(TKey key) const {
    // clear out the sign bit
    // basically this is the maximum value of signed 32 bit integer
    // so we can use it to get only the positive value of the key
    return key & 0x7FFFFFFF % m_capacity;
}

int Map::getNextPosition(int position, int i) const {
    return (position + i * i) % m_capacity;
}

void Map::resize() {
    //resize of multimap
    int oldCapacity = m_capacity;
    Node* oldHashtable = m_hashtable;

    m_capacity *= 2;
    m_hashtable = new Node[m_capacity]();

    for (int i = 0; i < oldCapacity; i++) {
        if (oldHashtable[i].valid) {
            int position = hash(oldHashtable[i].element.first);
            int j = 0;
            while (m_hashtable[getNextPosition(position, j)].valid) {
                j++;
            }
            m_hashtable[getNextPosition(position, j)] = oldHashtable[i];
        }
    }

    delete[] oldHashtable;//delete old hashtable
}

TValue Map::add(TKey c, TValue v){
    if (m_size >= m_capacity / 2) {
        resize();
    }

    int position = hash(c);
    int i = 0;
    int next = getNextPosition(position, i);
    while (m_hashtable[next].valid) {
        if (m_hashtable[next].element.first == c) {
            // key already exists
            TValue oldValue = m_hashtable[next].element.second;
            // replace the value
            m_hashtable[next].element.second = v;
            return oldValue;
        }
        i++;
        next = getNextPosition(position, i);
    }

    m_hashtable[next].element = std::make_pair(c, v);
    m_hashtable[next].valid = true;
    m_size++;
    return NULL_TVALUE;
}

TValue Map::search(TKey c) const{
    int position = hash(c);
    int i = 0;
    int next = getNextPosition(position, i);
    while (m_hashtable[next].valid) {
        if (m_hashtable[next].element.first == c) {
            return m_hashtable[next].element.second;
        }
        i++;
        next = getNextPosition(position, i);
    }
    return NULL_TVALUE;
}

TValue Map::remove(TKey c){
    //remove based on key and value
    int position = hash(c);
    int i = 0;
    int next = getNextPosition(position, i);
    while (m_hashtable[next].valid) {
        if (m_hashtable[next].element.first == c) {
            int old = m_hashtable[next].element.second;

            m_hashtable[next].valid = false;
            m_hashtable[next].element = NULL_TELEM;
            m_size--;
            // return the value
            return old;
        }
        i++;
        next = getNextPosition(position, i);
    }

    return NULL_TVALUE;  // not found
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
