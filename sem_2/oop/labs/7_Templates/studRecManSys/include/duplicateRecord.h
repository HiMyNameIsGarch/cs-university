#pragma once
#ifndef DUPLICATERECORD_H
#define DUPLICATERECORD_H

class DuplicateRecord {
public:
    DuplicateRecord() = default;
    const char* what() const noexcept {
        return "Duplicate record";
    }

};

#endif
