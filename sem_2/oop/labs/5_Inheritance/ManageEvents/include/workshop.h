#pragma once

#include "myEvent.h"
#include <iostream>
using std::string;

#ifndef WORKSHOP_H
#define WORKSHOP_H

class Workshop: public MyEvent {
protected:

private:
    string m_topic;

public:
    string topic() const {
        return m_topic;
    }

    void setTopic(string newtopic){
        m_topic = newtopic;
    }

    void displayEventDetails();

    Workshop(string name, string date, string loc, string topic);


};

#endif
