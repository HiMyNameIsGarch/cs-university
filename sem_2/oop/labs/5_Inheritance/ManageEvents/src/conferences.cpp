#include "../include/conferences.h"

Conferences::Conferences(string name, string date, string loc, string keynoteSpeaker)
    : MyEvent{name, date, loc} {

  m_keynoteSpeaker = keynoteSpeaker;
}

void Conferences::displayEventDetails() {
    MyEvent::displayEventDetails();
    std::cout << "Keynote Speaker: " << m_keynoteSpeaker << std::endl;
}

