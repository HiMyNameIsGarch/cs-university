// Implement the following structure of processes,
//     in which the vertices indicate the communication between
//         processes using pipes:



//   1
//  / \
// 2   3
//  \
//   4


// Parent process sends to the child a filename,
//     and the child sends back to the parent the content of the file or
//         an error message if the file does not exist.


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#define MAX_BUF 1024

int main() {
    int pipe1[2]; // Parent -> Child
    int pipe2[2]; // Child -> Parent

    if (pipe(pipe1) == -1 || pipe(pipe2) == -1) {
        perror("pipe");
        exit(1);
    }

    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(1);
    }

    if (pid > 0) {
        // ---- PARENT PROCESS ----
        close(pipe1[0]); // Close read end of pipe1
        close(pipe2[1]); // Close write end of pipe2

        char filename[256];
        printf("Enter filename: ");
        fgets(filename, sizeof(filename), stdin);
        filename[strcspn(filename, "\n")] = '\0'; // Remove newline

        // Send filename to child
        write(pipe1[1], filename, strlen(filename) + 1);
        close(pipe1[1]); // Done writing

        // Read response from child
        char buffer[MAX_BUF];
        ssize_t n;
        while ((n = read(pipe2[0], buffer, MAX_BUF - 1)) > 0) {
            buffer[n] = '\0';
            printf("%s", buffer);
        }
        close(pipe2[0]);

    } else {
        // ---- CHILD PROCESS ----
        close(pipe1[1]); // Close write end of pipe1
        close(pipe2[0]); // Close read end of pipe2

        char filename[256];
        read(pipe1[0], filename, sizeof(filename));
        close(pipe1[0]);

        int fd = open(filename, O_RDONLY);
        if (fd == -1) {
            char *msg = "Error: File does not exist or cannot be opened.\n";
            write(pipe2[1], msg, strlen(msg));
        } else {
            char buf[MAX_BUF];
            ssize_t n;
            while ((n = read(fd, buf, MAX_BUF)) > 0) {
                write(pipe2[1], buf, n);
            }
            close(fd);
        }
        close(pipe2[1]);
        exit(0);
    }

    return EXIT_SUCCESS;
}
