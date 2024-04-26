#pragma once
#ifndef PAIR_H
#define PAIR_H

template <typename T, typename V> class Pair {
private:
    T first;
    V second;

public:
    Pair(T first, V second) {
        this->first = first;
        this->second = second;
    }

    T getFirst() {
        return first;
    }

    V getSecond() {
        return second;
    }

    void setFirst(T first) {
        this->first = first;
    }

    void setSecond(V second) {
        this->second = second;
    }

};

#endif
