#pragma once
#include "fsComponent.h"
#include <iostream>
#include "fileType.h"

#ifndef TEXTFILE_H
#define TEXTFILE_H

class TextFile: public FsComponent {
protected:

private:
    unsigned int m_size;
    FileType m_type = FileType::TEXT;

public:
    TextFile(const string &path, const FileType &type);

    unsigned int size() const override;

    void display() const override;

    FileType type() const  {
        return m_type;
    }

};

#endif
