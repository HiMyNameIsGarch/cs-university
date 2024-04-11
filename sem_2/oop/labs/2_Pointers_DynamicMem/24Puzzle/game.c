#include "game.h"
#include <stdio.h>
// #include "generator.h"
// #include "filewritter.h"

void startgame(bool mode) {
    printf("The game has started, prepare your calculations!\n");
}

void savesolutions() {
    printf("I will start saving the solutions\n");
}

void helpmenu() {
    printf("Usage: ./main [OPTION]\n\n");
    printf("The 24 puzzle is math game in which the player is given 4\n");
    printf("digits and he/she must figure out a way of combing these digits and\n");
    printf("the addition (+), subtraction (-), multiplication (*), and division (/)\n");
    printf("operators such that the result is 24.\n");
    printf("The result is computed in sequential order on the digits. For example,\n");
    printf("if the digits are 3, 4, 4, 9 and the user enters the three operations as\n");
    printf("  +, -, *, / then the calculation is done as follows:\n\n");
    printf("3 + 4 = 7.\n7 - 4 = 3. \n3 * 9 = 21.\n");

    printf("\n[OPTION]:\n");
    printf("  -h:     display information about how the game is played and exit.\n");
    printf("  -s:     save all the possible solutions for the game in a text file called “solution.txt” and then exit.\n");
    printf("  -e:     play the game in easy mode\n");
}
