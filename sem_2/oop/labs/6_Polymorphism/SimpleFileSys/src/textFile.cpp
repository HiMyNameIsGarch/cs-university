#include "../include/textFile.h"

TextFile::TextFile(const string &path, const FileType &type) : FsComponent(path), m_type(type) {
    m_size = 0;
}

unsigned int TextFile::size() const {
    return m_size;
}

void TextFile::display() const {
    std::cout << "Path: " << path() << std::endl;
    std::cout << "Size: " << size() << std::endl;
}

