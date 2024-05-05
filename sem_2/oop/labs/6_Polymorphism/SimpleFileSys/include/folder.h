#pragma once
#include "fsComponent.h"
#include <vector>
#ifndef FOLDER_H
#define FOLDER_H

class Folder: public FsComponent {

private:
    std::vector<FsComponent *> m_components;

public:
    Folder(const string &path);

    unsigned int size() const override;

    void display() const override;

    void addComponent(FsComponent *component);

    ~Folder();
};

#endif
