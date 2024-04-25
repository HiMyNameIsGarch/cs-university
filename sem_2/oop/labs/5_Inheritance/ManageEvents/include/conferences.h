#pragma once

#include "myEvent.h"
#include <iostream>
using std::string;

#ifndef CONFERENCES_H
#define CONFERENCES_H

class Conferences: public MyEvent {
protected:

private:
    std::string m_keynoteSpeaker;

public:
    std::string keynoteSpeaker() const {
        return m_keynoteSpeaker;
    }

    void set(std::string newSpeaker){
        m_keynoteSpeaker = newSpeaker;
    }

    void displayEventDetails();

    Conferences(string name, string date, string loc, string speaker);

};

#endif
