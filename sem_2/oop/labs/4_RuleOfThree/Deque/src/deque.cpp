#include "../include/deque.h"

Deque::Deque() {
    numChunks = 0;
    cap = 0;
    chunks = new int *[1];
    begin = 0;
    end = 0;
    currentChunk = 0;
}

// Private
void Deque::copy(const Deque& other) {
    printf("Please implement me!\n");
    this->numChunks = other.numChunks;
}

void Deque::clear() {
    // Free memory for each chunk
    for (int i = 0; i < numChunks; ++i) {
        delete[] chunks[i];
    }
    // Free memory for the array of pointers
    delete[] chunks;
}


// Standard operations on a deque
void Deque::push_back(const int& value) {
    // If the deque is empty, we need to allocate memory for the first chunk
    if(is_empty()) {
        chunks[currentChunk] = new int[CHUNK_SIZE];
        numChunks++;
        chunks[currentChunk][begin] = value;
        begin = (begin + 1) % CHUNK_SIZE;
        return;
    }
    // If there are some elements in the chunks, we need to check if we have
    // space in the current chunk
    if (begin == CHUNK_SIZE) {
        // If we are at the begin of the chunk, we need to move to the next chunk
        // and reset the begin index
        // Also we need to allocate the memory if we are at the begin of the chunks
        currentChunk = (currentChunk + 1) % numChunks;
        if (currentChunk < numChunks) {
            chunks[currentChunk] = new int[CHUNK_SIZE];
        }
        begin = 0;
    } else {
        begin = (begin + 1) % CHUNK_SIZE;
    }
    chunks[currentChunk][begin] = value;
}

void Deque::push_front(const int& value) {
    // If the deque is empty, we need to allocate memory for the first chunk
    if(is_empty()) {
        // If we are at the begin of the chunks, we need to create the chunk
        chunks[currentChunk] = new int[CHUNK_SIZE];
        // Increase the number of the chunks, prev was 0
        numChunks++;
        // just place the value at the end of the chunk
        chunks[currentChunk][end] = value;
        end = (end + 1) % CHUNK_SIZE;
        cap++;
        return;
    }
    // Check if the chunks are full
    if(cap % CHUNK_SIZE == 0) {
        chunks[currentChunk++] = new int[CHUNK_SIZE];
        numChunks++;
        chunks[currentChunk][end] = value;
        end = (end + 1) % CHUNK_SIZE;
        cap++;
        return;
    }
    chunks[currentChunk][end] = value;
    end = (end + 1) % CHUNK_SIZE;
    cap++;
}

void Deque::pop_front() {
    if(is_empty())
        return;
    chunks[currentChunk][end] = 0;
    end = (end + 1) % CHUNK_SIZE;
    if (end == 0) {
        currentChunk = (currentChunk + 1) % numChunks;
    }
}

void Deque::pop_back() {
    if(is_empty())
        return;
    // If the deque is empty, we need to allocate memory for the first chunk
    chunks[currentChunk][begin] = 0;
    begin = (begin - 1) % CHUNK_SIZE;
    // If we are at the beginning of the chunk, we need to move to the previous chunk
    if (begin == 0) {
        currentChunk = (currentChunk - 1) % numChunks;
    }
}

int Deque::top() {
    return chunks[currentChunk][begin];
}

// Optional operations
int Deque::back() {
    return chunks[currentChunk][end];
}

bool Deque::is_empty() {
    return size() == 0 && cap == 0;
}

int Deque::size() {
    return numChunks;
}

// Rule of three
Deque::Deque(const Deque& other) {
    printf("Please implement me!\n");
    this->numChunks = other.numChunks;
}

Deque& Deque::operator=(const Deque& other) {
    clear();
    copy(other);
    return *this;
}

Deque::~Deque() {
    clear();
    numChunks = 1;
    cap = begin = end = currentChunk = 0;
}

// Print the deque
std::ostream& operator<<(std::ostream& os, const Deque& deq) {
    os << deq.numChunks;
    printf("Please implement me!\n");
    return os;
}

std::istream& operator>>(std::istream& is, Deque& deq) {
    deq = Deque();
    printf("Please implement me!\n");
    return is;
}
