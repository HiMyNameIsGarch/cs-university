#pragma once

#include <iostream>
using std::string;

#ifndef MYEVENT_H
#define MYEVENT_H

class MyEvent {
protected:
    string eventName;
    string eventDate;
    string location;


private:

public:
    void displayEventDetails();
    MyEvent();
    MyEvent(string name, string date, string loc);

};

#endif
