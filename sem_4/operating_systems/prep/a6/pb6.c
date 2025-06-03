#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <ctype.h>

#define NUM_LETTERS 26
#define BUFFER_SIZE 1024

// Given Pi the process that determines the frequency of occurrences of letter i
// in a given text. Write a program that uses such processes to print a
// statistic of frequency for each letter occurrence.

// Structure to hold letter count
typedef struct {
    char letter;
    int count;
} LetterCount;

// Function for child process to count a specific letter
void count_letter(char letter, const char *text, int write_fd) {
    int count = 0;
    for (int i = 0; text[i] != '\0'; i++) {
        if (tolower(text[i]) == tolower(letter)) {
            count++;
        }
    }

    LetterCount result = {letter, count};
    write(write_fd, &result, sizeof(LetterCount));
    close(write_fd);
    exit(0);
}

int main() {
    char text[BUFFER_SIZE];
    int pipes[NUM_LETTERS][2];
    pid_t pids[NUM_LETTERS];

    // Get input text
    printf("Enter text to analyze: ");
    fgets(text, BUFFER_SIZE, stdin);
    text[strcspn(text, "\n")] = '\0'; // Remove newline

    // Create pipes for all letters
    for (int i = 0; i < NUM_LETTERS; i++) {
        if (pipe(pipes[i]) == -1) {
            perror("Pipe creation failed");
            exit(EXIT_FAILURE);
        }
    }

    // Create child processes for each letter
    for (int i = 0; i < NUM_LETTERS; i++) {
        pids[i] = fork();

        if (pids[i] == -1) {
            perror("Fork failed");
            exit(EXIT_FAILURE);
        }

        if (pids[i] == 0) { // Child process
            close(pipes[i][0]); // Close read end
            count_letter('a' + i, text, pipes[i][1]);
        } else { // Parent process
            close(pipes[i][1]); // Close write end
        }
    }

    // Wait for all child processes to complete
    for (int i = 0; i < NUM_LETTERS; i++) {
        waitpid(pids[i], NULL, 0);
    }

    // Collect results from all pipes
    LetterCount results[NUM_LETTERS];
    for (int i = 0; i < NUM_LETTERS; i++) {
        read(pipes[i][0], &results[i], sizeof(LetterCount));
        close(pipes[i][0]);
    }

    // Calculate total letters for percentage
    int total_letters = 0;
    for (int i = 0; i < NUM_LETTERS; i++) {
        total_letters += results[i].count;
    }

    // Print statistics
    printf("\nLetter Frequency Statistics:\n");
    printf("--------------------------\n");
    printf("Letter | Count | Percentage\n");
    printf("--------------------------\n");

    for (int i = 0; i < NUM_LETTERS; i++) {
        if (results[i].count > 0) {
            float percentage = (total_letters > 0) ?
                (float)results[i].count * 100 / total_letters : 0;
            printf("   %c   | %5d | %8.2f%%\n",
                  results[i].letter, results[i].count, percentage);
        }
    }

    return 0;
}
