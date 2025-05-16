#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <stdbool.h>
#include <math.h>

#define MAX_PROCESSES 50

void sieve_process(int i, bool *numbers, int N) {
    for (int j = i * 2; j <= N; j += i) {
        numbers[j] = false;
    }
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <N>\n", argv[0]);
        return 1;
    }

    int N = atoi(argv[1]);
    if (N < 2) {
        printf("No primes in the specified range.\n");
        return 0;
    }

    // Calculate required shared memory size
    size_t shm_size = (N + 1) * sizeof(bool);

    // Create shared memory segment
    int shmid = shmget(IPC_PRIVATE, shm_size, IPC_CREAT | 0666);
    if (shmid < 0) {
        perror("shmget");
        return 1;
    }

    // Attach shared memory segment
    bool *numbers = (bool *)shmat(shmid, NULL, 0);
    if (numbers == (bool *)-1) {
        perror("shmat");
        return 1;
    }

    // Initialize numbers
    for (int i = 0; i <= N; i++) {
        numbers[i] = true;
    }
    numbers[0] = numbers[1] = false;

    // Create processes with limit
    int processes_created = 0;
    for (int i = 2; i <= sqrt(N) && processes_created < MAX_PROCESSES; i++) {
        if (numbers[i]) {
            pid_t pid = fork();
            if (pid == 0) {
                sieve_process(i, numbers, N);
                exit(0);
            } else if (pid < 0) {
                perror("fork");
                return 1;
            }
            processes_created++;
        }
    }

    // Wait for all child processes
    while (wait(NULL) > 0);

    // Print primes
    printf("Prime numbers between 1 and %d:\n", N);
    for (int i = 2; i <= N; i++) {
        if (numbers[i]) {
            printf("%d ", i);
        }
    }
    printf("\n");

    // Cleanup
    shmdt(numbers);
    shmctl(shmid, IPC_RMID, NULL);

    return 0;
}
