#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>

#define MAX_SIZE 1000

bool is_prime(unsigned int n);
void test();

bool is_prime(unsigned int n)
{
    if (n < 2) {
        return false;
    }
    if (n > 2 && n % 2 == 0) {
        return false;
    }
    for (unsigned int i = 3; i * i < n; i = i+2) {
        if (n % i == 0) {
            return false;
        }
    }
    return true;
}

void mark_prime(uint arr[MAX_SIZE], uint mult, uint n) {
    for(uint i = mult; i <= n; i = i + mult) {
        arr[i] = false;
    }
}

void gen_primes(uint n, uint arr[MAX_SIZE], int *p)
{
    bool sieve[MAX_SIZE];
    sieve[0] = sieve[1] = false;
    uint d = 2;
    *p = 0;
    while (d <= n && sieve[++d]) {
        arr[*++p] = d;
        mark_prime(arr, d, n);
    }
}

void test() {
    assert(!is_prime(0));
    assert(!is_prime(1));
    assert(is_prime(2));
    assert(is_prime(3));
}

int main()
{
    uint n;
    scanf("%d", &n);
    return 0;
}
