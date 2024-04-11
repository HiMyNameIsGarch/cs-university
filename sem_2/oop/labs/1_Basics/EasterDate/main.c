#include <stdio.h>

void strcopy(char str[5], char newStr[]){
    int i = 0;
    do {
        str[i] = newStr[i];
    } while(str[i++]);
}

int main() {
    int year;
    scanf("%d", &year);

    if(year < 1876) {
        printf("Invalid input, the year should be greater or equal to 1876\n");
        return 1;
    }

    int A = year % 19;
    int B = year % 4;
    int C = year % 7;
    int D = (19 * A + 24) % 30;
    int E = (2*B + 4*C + 6*D + 5) % 7;

    int easter = 22 + E + D;

    char month[5];
    if (easter < 31) {
        strcopy(month, "March");
    } else {
        strcopy(month, "April");
        easter -= 31;
    }

    printf("In year %u the Easter date is %s ", year, month);
    (easter < 10) ? printf("0%d\n", easter) : printf("%d\n", easter);

    return 0;
}
