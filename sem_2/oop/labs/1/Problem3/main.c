#include <stdio.h>
#include <stdlib.h>

void bin(unsigned n, short int *count) {
    unsigned i;
    for (i = 1 << 31; i > 0; i = i / 2)
        if (n & i) {
            *count = *count + 1;
        }
}

int main() {
    unsigned n;
    n = -1;
    // scanf("%u", &n);

    short int count;
    bin(n, &count);
    printf("%hd\n", count);
    return 0;
}
