#pragma once
#ifndef INVALIDGRADEVALUE_H
#define INVALIDGRADEVALUE_H

class InvalidGradeValue {
private:

public:
    InvalidGradeValue() = default;
    const char* what() const noexcept {
        return "Invalid grade";
    }

};

#endif
