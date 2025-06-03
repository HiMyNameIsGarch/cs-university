#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

/*
 * The following arithmetic expression is given (a+b*c) / (a-b+d-c) + a*b*c*d.
 * Write a program that determines the value of this expression, such that each
 * arithmetical operation is executed by a separate process.
 */

int main(int argc, char *argv[]) {

    float a,b,c,d;
    float result1, result2, result3, final_result;

    printf("Input values: for a, b, c, d: ");
    scanf("%f %f %f %f", &a, &b, &c, &d);


    int pipe1[2], pipe2[2], pipe3[2], pipe4[2], pipe5[2], pipe6[2];
    if (pipe(pipe1) == -1 || pipe(pipe2) == -1 || pipe(pipe3) == -1 ||
        pipe(pipe4) == -1 || pipe(pipe5) == -1 || pipe(pipe6) == -1) {
        perror("Pipe creation failed");
        exit(EXIT_FAILURE);
    }


    pid_t pid1 = fork();
    if (pid1 == 0) {
        float temp = b * c;
        write(pipe1[1], &temp, sizeof(float));
        close(pipe1[1]);
        exit(EXIT_SUCCESS);
    }

        // Second operation: a + (b*c)
    pid_t pid2 = fork();
    if (pid2 == 0) { // Child process 2
        float temp;
        read(pipe1[0], &temp, sizeof(float));
        close(pipe1[0]);
        temp = a + temp;
        write(pipe2[1], &temp, sizeof(float));
        close(pipe2[1]);
        exit(0);
    }

    // Third operation: a - b
    pid_t pid3 = fork();
    if (pid3 == 0) { // Child process 3
        float temp = a - b;
        write(pipe3[1], &temp, sizeof(float));
        close(pipe3[1]);
        exit(0);
    }

    // Fourth operation: (a-b) + d
    pid_t pid4 = fork();
    if (pid4 == 0) { // Child process 4
        float temp;
        read(pipe3[0], &temp, sizeof(float));
        close(pipe3[0]);
        temp = temp + d;
        write(pipe4[1], &temp, sizeof(float));
        close(pipe4[1]);
        exit(0);
    }

    // Fifth operation: (a-b+d) - c
    pid_t pid5 = fork();
    if (pid5 == 0) { // Child process 5
        float temp;
        read(pipe4[0], &temp, sizeof(float));
        close(pipe4[0]);
        temp = temp - c;
        write(pipe5[1], &temp, sizeof(float));
        close(pipe5[1]);
        exit(0);
    }

    // Sixth operation: (a+b*c)/(a-b+d-c)
    pid_t pid6 = fork();
    if (pid6 == 0) { // Child process 6
        float temp1, temp2;
        read(pipe2[0], &temp1, sizeof(float));
        close(pipe2[0]);
        read(pipe5[0], &temp2, sizeof(float));
        close(pipe5[0]);
        if (temp2 == 0) {
            printf("Error: Division by zero\n");
            exit(EXIT_FAILURE);
        }
        temp1 = temp1 / temp2;
        write(pipe6[1], &temp1, sizeof(float));
        close(pipe6[1]);
        exit(0);
    }

    // Seventh operation: a*b
    pid_t pid7 = fork();
    if (pid7 == 0) { // Child process 7
        float temp = a * b;
        write(pipe1[1], &temp, sizeof(float));
        close(pipe1[1]);
        exit(0);
    }

    // Eighth operation: (a*b)*c
    pid_t pid8 = fork();
    if (pid8 == 0) { // Child process 8
        float temp;
        read(pipe1[0], &temp, sizeof(float));
        close(pipe1[0]);
        temp = temp * c;
        write(pipe2[1], &temp, sizeof(float));
        close(pipe2[1]);
        exit(0);
    }

    // Ninth operation: (a*b*c)*d
    pid_t pid9 = fork();
    if (pid9 == 0) { // Child process 9
        float temp;
        read(pipe2[0], &temp, sizeof(float));
        close(pipe2[0]);
        temp = temp * d;
        write(pipe3[1], &temp, sizeof(float));
        close(pipe3[1]);
        exit(0);
    }

    // Parent process - collect results and compute final expression
    float numerator, denominator, product;

    // Get numerator (a+b*c)/(a-b+d-c)
    read(pipe6[0], &numerator, sizeof(float));
    close(pipe6[0]);

    // Get denominator part (a*b*c*d)
    read(pipe3[0], &product, sizeof(float));
    close(pipe3[0]);

    // Wait for all child processes to complete
    while(wait(NULL) < 0);

    // Compute final result
    final_result = numerator + product;

    // Print the result
    printf("Final result: %.2f\n", final_result);

    return 1;
}


