#pragma once
#include <iostream>
#ifndef FILENOTFOUND_H
#define FILENOTFOUND_H

class FileNotFound {
private:
    std::string m_filename;
public:
    FileNotFound(std::string filename) : m_filename(filename) {};

    const std::string what() const noexcept {
        // return a string that contains the filename and the error message
        // "File not found: <filename>"
        return ("File not found: " + m_filename).c_str();
    }

};

#endif
