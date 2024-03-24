#include <stdio.h>

void generate_pins(int digits[], int index, int sum) {
    if (index == 4){
        if (sum == 24) {
            printf("%d%d%d%d\n", digits[0], digits[1], digits[2], digits[3]);
        }
        return;
    }

    // Start from the biggest number and then decrement
    int start = (index == 0) ? 9 : digits[index - 1] - 1;
    for(int i = start; i >= 0; i--){
        digits[index] = i;
        generate_pins(digits, index + 1, sum + i);
    }
}

int main() {
    printf("PIN codes for Alice in decreasing order:\n");
    int digits[4];
    generate_pins(digits, 0, 0);
    return 0;
}

