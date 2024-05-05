#pragma once

#include <iostream>
using std::string;

#ifndef FSCOMPONENT_H
#define FSCOMPONENT_H

class FsComponent {
protected:
    string m_path;

public:
    FsComponent(const string &path);

    virtual ~FsComponent() = default;

    string path() const {
        return m_path;
    }

    virtual unsigned int size() const = 0;

    virtual void display() const = 0;

};

#endif
