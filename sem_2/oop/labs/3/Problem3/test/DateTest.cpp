#include "../include/DateTest.h"
#include <assert.h>

void DateTest::testCreationDefault(){
    Date date;
    assert(date.day() == 1);
    assert(date.month() == 1);
    assert(date.year() == 1970);
}
void DateTest::testCreationWithParams(){
    Date date(2024, 4, 2);
    assert(date.day() == 2);
    assert(date.month() == 4);
    assert(date.year() == 2024);

    Date date1(2024, 4, -2);
    assert(date1.day() == 1);
    assert(date1.month() == 1);
    assert(date1.year() == 1970);
}
void DateTest::areDatesEqual(){
    Date date1(2024, 4, 2);
    Date date2(2024, 4, 2);
    assert(date1 == date2);
    Date date3(2025, 4, 2);
    assert(!(date1 == date3));
}
void DateTest::areDatesNotEqual(){
    Date date1(2024, 4, 2);
    Date date2(2024, 4, 2);
    assert(!(date1 != date2));
    Date date3(2025, 4, 2);
    assert(date1 != date3);
}

void DateTest::areDatesLessThan(){
    Date date1(2024, 4, 2);
    Date date2(2025, 4, 2);
    assert(date1 < date2);
    Date date3(2024, 4, 2);
    assert(!(date1 < date3));
}
void DateTest::areDatesLessThanOrEqual(){
    Date date1(2024, 4, 2);
    Date date2(2025, 4, 2);
    assert(date1 <= date2);
    Date date3(2024, 4, 2);
    assert(date1 <= date3);
}

void DateTest::areDatesGreaterThan(){
    Date date1(2024, 4, 2);
    Date date2(2025, 4, 2);
    assert(date2 > date1);
    Date date3(2024, 4, 2);
    assert(date3 > date1);
}
void DateTest::areDatesGreaterThanOrEqual(){
    Date date1(2024, 4, 2);
    Date date2(2025, 4, 2);
    assert(date2 > date1);
    Date date3(2024, 4, 2);
    assert(date3 >= date1);
}

void DateTest::addDays(){
    Date date(2024, 4, 2);
    date.addDays(1);
    assert(date.day() == 3);
    assert(date.month() == 4);
    assert(date.year() == 2024);

    date.addDays(30);
    assert(date.day() == 3);
    assert(date.month() == 5);
    assert(date.year() == 2024);

    date.addDays(365);
    assert(date.day() == 3);
    assert(date.month() == 5);
    assert(date.year() == 2025);
}

void DateTest::testAll() {
    DateTest::addDays();
    DateTest::areDatesEqual();
    DateTest::areDatesNotEqual();
    DateTest::areDatesLessThan();
    DateTest::areDatesLessThanOrEqual();
    DateTest::areDatesGreaterThan();
    DateTest::areDatesGreaterThanOrEqual();
    DateTest::testCreationDefault();
    DateTest::testCreationWithParams();
}
