#pragma once

#include "myEvent.h"
#include <iostream>
using std::string;

#ifndef CONCERTS_H
#define CONCERTS_H

class Concerts: public MyEvent {
protected:

private:
    string m_keynoteArtist;

public:
    string keynoteArtist() const {
        return m_keynoteArtist;
    }

    void set(string newArtist){
        m_keynoteArtist = newArtist;
    }

    void displayEventDetails();

    Concerts(string name, string date, string loc, string artist);

};

#endif
