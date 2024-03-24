#include <stdio.h>
// #include <stdlib.h>
#include "dynarr.h"

int main() {
    DynArr arr = create(12);
    add(&arr, 1);
    add(&arr, 2);
    add(&arr, 3);
    add(&arr, 4);
    add(&arr, 5);
    add(&arr, 6);
    add(&arr, 7);
    add(&arr, 8);
    add(&arr, 9);
    add(&arr, 10);
    add(&arr, 11);
    add(&arr, 12);
    display(&arr);
    return 0;
}
