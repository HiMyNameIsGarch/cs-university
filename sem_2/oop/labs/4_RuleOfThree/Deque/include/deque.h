#ifndef DEQUE_H
#define DEQUE_H

#include <iostream>

class Deque {

private:
    // struct Node {
    //     int value;
    //     Node* next;
    //     Node* prev;
    // };

    // Node* head;
    // Node* tail;
    int *head;
    int *tail;

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
