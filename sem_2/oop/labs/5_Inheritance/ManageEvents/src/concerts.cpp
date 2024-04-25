#include "../include/concerts.h"

Concerts::Concerts(string name, string date, string loc, string noteArtist)
    : MyEvent{name, date, loc} {

  m_keynoteArtist = noteArtist;
}

void Concerts::displayEventDetails() {
    MyEvent::displayEventDetails();
    std::cout << "Keynote Artist: " << m_keynoteArtist << std::endl;
}
