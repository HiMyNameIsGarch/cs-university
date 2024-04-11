#include "deque.h"

template <typename T> Deque<T>::Deque() {
    head = nullptr;
    tail = nullptr;
}

// Private
template <typename T> void Deque<T>::copy(const Deque& other) {
    printf("Please implement me!\n");
}

template <typename T> void Deque<T>::clear() {
    printf("Please implement me!\n");
}


// Standard operations on a deque
template <typename T> void Deque<T>::push_back(const T& value) {
    printf("Please implement me!\n");
}

template <typename T> void Deque<T>::push_front(const T& value) {
    printf("Please implement me!\n");
}

template <typename T> void Deque<T>::pop_front() {
    printf("Please implement me!\n");
}

template <typename T> void Deque<T>::pop_back() {
    printf("Please implement me!\n");
}

template <typename T> T Deque<T>::top() {
    printf("Please implement me!\n");
    return T();
}

// Optional operations
template <typename T> T Deque<T>::back() {
    printf("Please implement me!\n");
    return T();
}

template <typename T> bool Deque<T>::is_empty() {
    printf("Please implement me!\n");
    return false;
}

template <typename T> T Deque<T>::size() {
    printf("Please implement me!\n");
    return T();
}

// Rule of three
template <typename T> Deque<T>::Deque(const Deque& other) {
    printf("Please implement me!\n");
}

template <typename T> Deque<T>& Deque<T>::operator=(const Deque& other) {
    printf("Please implement me!\n");
    return *this;
}

template <typename T> Deque<T>::~Deque() {
    printf("Please implement me!\n");
    clear();
}

// Print the deque
template <typename T> std::ostream& operator<<(std::ostream& os, const Deque<T>& deq) {
    printf("Please implement me!\n");
    return os;
}

template <typename T> std::istream& operator>>(std::istream& is, Deque<T>& deq) {
    printf("Please implement me!\n");
    return is;
}
