#include <stdio.h>
#include <string.h>
#include "game.h"

int main(int argc, char **argv) {
    if (argc == 1) {
        printf("No arguments were entered, the game will enter in full mode!\n");
        startgame(true);
        return 0;
    }
    if (!strcmp(argv[1], "-h")){
        helpmenu();
        return 0;
    }
    if (!strcmp(argv[1], "-s")) {
        printf("All possible solutions will be saved in a file called solution.txt\n");
        savesolutions();
        return 0;
    }
    if (!strcmp(argv[1], "-e")) {
        startgame(false);
        return 0;
    }
    printf("Invalid argument: '%s', please use -h for help\n", argv[1]);
    return 1;
}
