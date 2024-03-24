#include <stdio.h>
#include <stdlib.h>

const char * my_strchr ( const char * str, char character ) {
    if(str == NULL) {
        return NULL;
    }
    const char *it = str;
    while(*it != '\0') {
        if(*it == character) {
            return it;
        }
        it++;
    }
    return NULL;
}

int main() {
    char *str = (char *)malloc(sizeof(char));
    printf("Put a string: ");
    scanf("%s", str);
    getchar();

    printf("Put a character: ");
    char ch;
    scanf("%c", &ch);

    const char *mychar = my_strchr(str, ch);
    printf("%s\n",mychar);
    free(str);
    return 0;
}
