#include <stdio.h>

void encrypt(char *encrypted, short unsigned int shift) {
    for (int i = 0; encrypted[i] != '\0'; i++) {
        // For uppercase letters
        if (encrypted[i] >= 'A' && encrypted[i] <= 'Z') {
            encrypted[i] = (encrypted[i] - 'A' - shift + 26) % 26 + 'A';

        } else if (encrypted[i] >= 'a' && encrypted[i] <= 'z') {
            encrypted[i] = (encrypted[i] - 'a' - shift + 26) % 26 + 'a';
        }
    }
}

int main() {
    short unsigned int shift;
    printf("Enter code: ");
    scanf("%hu", &shift);

    char txt[100];
    printf("Enter text: ");
    getchar();
    fgets(txt, 99, stdin);

    encrypt(txt, shift);
    printf("Encrypted: %s\n", txt);
    return 0;
}
