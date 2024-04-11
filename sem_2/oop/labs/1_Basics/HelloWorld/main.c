#include <stdio.h>

int main()
{
    char name[64];
    printf("\rEnter your name: ");
    fgets(name, 63, stdin); // scanf with null character and space

    short int year;
    printf("Enter your birth year: ");
    scanf("%4hd", &year);

    printf("Name: %s, Year: %hd\n", name, year);
    return 0;
}

