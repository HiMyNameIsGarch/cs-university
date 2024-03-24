#define _CRTDBG_MAP_ALLOC
#include <stdio.h>
#include <stdlib.h>

// - str - a C string in which we will search the character;
// - character - the character to be searched;
// - positions - [in/out] param. Array containing all the positions on which the character character
// occurs in the string str. First fill this array with -1!
// - cap - the capacity of the positions array (the maximum number of elements that you can add
// in the array). If there are more occurrences of character in str you can and should only store
// the positions for the first cap ones.
// - l - [in/out] parameter. The length of the positions array (the number of elements currently in
// the array - i.e. the number of times character occurs in str ).
void find_all( const char * str, char character, int* positions, unsigned int cap, unsigned int * l) {
    int i = 0;
    int j = 0;
    while (str[i] != '\0') {
        if (str[i] == character) {
            if (j < cap) {
                positions[j] = i;
                j++;
            }
            *l = j;
        }
        i++;
    }
}

int main() {
    char *str = (char *)malloc(sizeof(char));
    printf("Put a string: ");
    scanf("%s", str);
    getchar();

    printf("Put a character: ");
    char ch;
    scanf("%c", &ch);
    getchar();

    printf("Put a capacity: ");
    short cap;
    scanf("%hd", &cap);

    int *positions = (int *)malloc(sizeof(int));
    unsigned int l = 0;
    find_all(str, ch, positions, cap, &l);

    printf("The character %c occurs in the string %s at the following positions: ", ch, str);
    for (int i = 0; i < l; i++) {
        printf("%d ", positions[i]);
    }
    printf("\n");

    free(str);
    free(positions);
    return 0;
}
