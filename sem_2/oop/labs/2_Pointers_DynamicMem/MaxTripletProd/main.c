#include <stdio.h>
#include <stdlib.h>

long long maxTriplet(int *arr, uint sz, int *t1, int *t2, int *t3) {
    if(sz == 3) {
        *t1 = arr[0];
        *t2 = arr[1];
        *t3 = arr[2];
        return *t1 * *t2 * *t3;
    }

    // get the highest product of 3 numbers:
    int min1, min2 = 0;
    int max1, max2, max3 = 1;
    for(short i = 0; i < sz; i++) {
        if (arr[i] < 0) {
            if (arr[i] < min1) {
                min2 = min1;
                min1 = arr[i];
            } else if (arr[i] < min2) {
                min2 = arr[i];
            }
        } else if (arr[i] > 0) {
            if (arr[i] > max1) {
                max3 = max2;
                max2 = max1;
                max1 = arr[i];
            } else if (arr[i] > max2) {
                max3 = max2;
                max2 = arr[i];
            } else if (arr[i] > max3) {
                max3 = arr[i];
            }
        }
    }

    *t1 = min1;
    if(min1*min2 <= 0) {
        *t2 = max1;
        *t3 = max2;
    }
    else {
        *t2 = min2;
        *t3 = max1;
    }
    long long p1 = *t1 * *t2 * *t3;
    return p1;
}

int main(int argc, char *argv[]) {
    uint n;
    scanf("%u", &n);
    if(n < 3) {
        printf("The array has less than 3 elements. Application will now stop.\n");
        return 1;
    }

    int *a = (int *)malloc(n * sizeof(int));
    for(short i = 0; i < n; i++) {
        printf("Put a number for arr of idx %d: ", i);
        scanf("%d", &a[i]);
    }

    int a1, a2, a3;
    long long p = maxTriplet(a, n, &a1, &a2, &a3);
    free(a);
    printf("The maximum triplet is (%d, %d, %d) and their product is %lld\n", a1, a2, a3, p);
    return 0;
}
