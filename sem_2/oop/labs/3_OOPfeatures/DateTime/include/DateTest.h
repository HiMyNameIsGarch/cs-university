#pragma once
#ifndef DATE_TEST_H
#define DATE_TEST_H
#include "Date.h"

class DateTest {
public:
    static void testCreationDefault();
    static void testCreationWithParams();


    static void areDatesEqual();
    static void areDatesNotEqual();

    static void areDatesLessThan();
    static void areDatesLessThanOrEqual();

    static void areDatesGreaterThan();
    static void areDatesGreaterThanOrEqual();

    static void addDays();

    static void testAll();

    // Dissallow creating an object of this class
    DateTest() = delete;
};

#endif // !DATE_TEST_H
