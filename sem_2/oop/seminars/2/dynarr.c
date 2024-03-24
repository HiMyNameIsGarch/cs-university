#include "dynarr.h"
#include <stdlib.h>
#include <stdio.h>


DynArr create(unsigned int cap){
    DynArr arr;
    arr.cap = cap;
    arr.length = 0;
    arr.arr = (short *)malloc(cap * sizeof(short));
    if(arr.arr == NULL) {
        printf("ERROR: while allocating memory for arr\n");
        exit(-1);
    }
    return arr;
}

void add(DynArr *d, short elem){
    if(d->length == d->cap){
        d->cap *= 2;
        d->arr = (short *)realloc(d->arr, d->cap * sizeof(short));
        if(d->arr == NULL) {
            printf("ERROR: while reallocating memory for arr\n");
            exit(-1);
        }
    }
    d->arr[d->length] = elem;
    d->length++;
}

void display(DynArr *d){
    printf("Your arr cap is: %d\n", d->cap);
    printf("Your arr length is: %d\n", d->length);
    for(int i = 0; i < d->length; i++){
        printf("%d ", d->arr[i]);
    }
}
