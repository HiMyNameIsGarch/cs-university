#include "../include/folder.h"

Folder::Folder(const string &path) : FsComponent(path) {}

void Folder::display() const {
    std::cout << "Path: " << path() << std::endl;
    std::cout << "Size: " << size() << std::endl;
    std::cout << "Contents: " << std::endl;

    for (auto &component: m_components) {
        component->display();
    }
}

void Folder::addComponent(FsComponent *component) {
    m_components.push_back(component);
}

unsigned int Folder::size() const {
    unsigned int total = 0;
    for (auto &component: m_components) {
        total += component->size();
    }
    return total;
}

Folder::~Folder() {
    for (auto &component: m_components) {
        delete component;
    }
}
