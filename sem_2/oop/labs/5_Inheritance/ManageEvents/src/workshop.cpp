#include "../include/workshop.h"

Workshop::Workshop(string name, string date, string loc, string topic)
    : MyEvent{name, date, loc} {
    m_topic = topic;
}

void Workshop::displayEventDetails() {
    MyEvent::displayEventDetails();
    std::cout << "Topic: " << m_topic << std::endl;
}

