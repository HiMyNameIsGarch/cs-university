#ifndef DEQUE_H
#define DEQUE_H

#include <iostream>

template <typename T>

class Deque {

private:
    struct Node {
        T value;
        Node* next;
        Node* prev;
    };

    Node* head;
    Node* tail;

    void copy(const Deque& other);
    void clear();

public:
    Deque();
    void push_front(const T& value);
    void pop_front();
    void push_back(const T& value);
    void pop_back();
    T top();
    T back();

    bool is_empty();
    T size();

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
