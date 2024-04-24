#ifndef DEQUE_H
#define DEQUE_H

#include <iostream>

constexpr int CHUNK_SIZE = 8;

class Deque {

private:
    int **chunks = nullptr;

    int cap;
    int numChunks;

    int begin;
    int end;
    int currentChunk;

    void copy(const Deque& other);
    void clear();

public:
    Deque();
    void push_front(const int& value);
    void pop_front();
    void push_back(const int& value);
    void pop_back();
    int top();
    int back();

    bool is_empty();
    int size();

    // Rule of three

    // Copy constructor
    Deque(const Deque& other);

    // Copy assignment operator
    Deque& operator=(const Deque& other);

    // Destructor
    ~Deque();

    // print the deque
    friend std::ostream& operator<<(std::ostream& os, const Deque& deq);
    friend std::istream& operator>>(std::istream& is, Deque& deq);

};

#endif
