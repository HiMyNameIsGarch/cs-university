#pragma once
#ifndef MALFORMEDDATA_H
#define MALFORMEDDATA_H

class MalformedData {
public:
    MalformedData() = default;
    const char* what() const noexcept {
        return "Malformed data";
    }
};

#endif
