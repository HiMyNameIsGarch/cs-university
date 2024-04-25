#include "../include/myEvent.h"

MyEvent::MyEvent() {
    eventName = " ";
    eventDate = " ";
    location = " ";
}

MyEvent::MyEvent(string name, string date, string loc) {
    eventName = name;
    eventDate = date;
    location = loc;
}

void MyEvent::displayEventDetails() {
    std::cout << "Event Name: " << eventName << std::endl;
    std::cout << "Event Date: " << eventDate << std::endl;
    std::cout << "Location: " << location << std::endl;
}

