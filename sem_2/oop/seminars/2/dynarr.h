typedef struct da DynArr;
struct da{
    short *arr;
    unsigned int length;
    unsigned int cap;
};

DynArr create(unsigned int cap);
void add(DynArr *d, short elem);
void display(DynArr *d);

