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

/*
my approach is based on Sieve of Eratosthenes but with a twist, parallelized
processes

The Sieve of Eratosthenes is an ancient algorithm used to find all prime numbers
up to a specified limit by iteratively marking the multiples of each prime
number starting from 2. It is an efficient method for generating a list of
primes, especially for smaller numbers.

It uses shared memory and multiple child processes to mark non-prime numbers
efficiently

It makes use of shmget and shmat to allow child processes to modify the same
boolean array, then it spawns multiple child processes up to MAX_PROCESSES to
mark non-prime numbers in parallel

Throughout the program we will use size_t instead of unsigned long ( shorter name )

*/

// this functions marks every multiple of i as non-prime number
// we start from i times 2 and increment gg
void sieve_process(int i, bool *numbers, int N) {
    for (int j = i * 2; j <= N; j += i) {
        numbers[j] = false;
    }
}

// helper function to read the last number from the file
int read_last_number(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Failed to open file");
        exit(EXIT_FAILURE);
    }

    int last_num = 0, num;
    while (fscanf(file, "%d", &num) == 1) {
        last_num = num;  // keep updating until the last number
    }

    fclose(file);
    return last_num;
}

int main(int argc, char *argv[]) {
    // check the numbers of parameters given by the end-user
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <N>\n", argv[0]);
        return 1;
    }

    // Read `N` from the last number in the file
    int N = read_last_number(argv[1]);

    // calculate required shared memory size
    size_t shm_size = (N + 1) * sizeof(bool);

    // create shared memory segment
    /*
       IPC_PRIVATE is the key ( unique ) which specifies that only the parent
       process and the children (created with fork() ) will have access to the
       shared boolean list

       shm_size is the size of the shared memory segment, which is the size of
       the boolean array

       IPC_CREAT flag is used to create the shared memory segment if it does not
       exit

       0666 permission parameter, you and your family (child processes) get
       read/write access.
    */
    int shmid = shmget(IPC_PRIVATE, shm_size, IPC_CREAT | 0666);
    if (shmid < 0) {
        perror("shmget failed to create shared memory, abording...");
        return EXIT_FAILURE;
    }

    // attach shared memory segment to the id we have created before
    bool *numbers = (bool *)shmat(shmid, NULL, 0);
    if (numbers == (bool *)-1) {
        perror("shmat failed to attach shared memory, abording...");
        return EXIT_FAILURE;
    }

    // initialize numbers
    for (int i = 0; i <= N; i++) {
        numbers[i] = true;
    }
    // first 2 numbers are already false as known to be not prime
    numbers[0] = numbers[1] = false;

    // create processes with limit
    int processes_created = 0; // keeping track of the processes created to enforce the limit
    /*
        The loop will go up to sqrt(N) because any composite number greater than
        sqrt(N) must have at least one factor less than or equal to sqrt(N)
        this is an optimization to reduce the number of processes created
    */
    for (int i = 2; i <= sqrt(N) && processes_created < MAX_PROCESSES; i++) {
        // check if the number is still marked as prime
        // if it is, we create a new process to mark its multiples as non-prime
        if (numbers[i]) {
            // create the damn fork and
            pid_t pid = fork();

            // 0 means success
            if (pid == 0) {
                // call the ancient and dummy algorithm
                sieve_process(i, numbers, N);
                exit(0); // to avoid continuing the loop (which would create
                         // unintended nested processes)
            } else if (pid < 0) {
                perror("fork failed, aborting...");
                return EXIT_FAILURE;
            }
            processes_created++;
        }
    }

    /*
     * This loop is crucial as the parent process will wait for all the child
     * processes to complete before continuing the execution of the code
     *
     * the function wait, waits for a child to die and returns the PID of the
     * terminated child and return -1 if no more children exist ( call Thanos in
     * case of emergency )
     */
    while (wait(NULL) > 0);

    // print primes, trivial functionality
    printf("Prime numbers between 1 and %d:\n", N);
    for (int i = 2; i <= N; i++) {
        if (numbers[i]) {
            printf("%d ", i);
        }
    }
    printf("\n");

    // cleanup the shared memory initialized
    shmdt(numbers);
    shmctl(shmid, IPC_RMID, NULL);

    return EXIT_SUCCESS;
}
