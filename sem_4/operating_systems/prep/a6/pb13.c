#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <fcntl.h>


/*
 * Calculate the product of an array n of numbers using divide et impera method:
 * a process splits the array in two sub-arrays and gives them to two other chid
 * processes to compute their product, then multiplies the results obtained from
 * the two. The two child processes apply the same technique (split, etc…).
 */


typedef struct {
    int *array;
    int start;
    int end;
} ArraySegment;

// Function to calculate product of an array segment
long long calculate_product(ArraySegment segment) {
    long long product = 1;
    for (int i = segment.start; i < segment.end; i++) {
        product *= segment.array[i];
    }
    return product;
}

// Recursive function that creates child processes
long long divide_and_conquer_product(ArraySegment segment, int depth) {
    // Base case: if segment is small enough, compute directly
    if (segment.end - segment.start <= 2) {
        return calculate_product(segment);
    }

    // Create pipe for communication with children
    int pipefd[2];
    if (pipe(pipefd) == -1) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    pid_t pid1, pid2;
    long long left_product = 1, right_product = 1;

    // Fork first child for left half
    pid1 = fork();
    if (pid1 == 0) { // Child process 1
        close(pipefd[0]); // Close read end
        ArraySegment left = {
            segment.array,
            segment.start,
            segment.start + (segment.end - segment.start) / 2
        };
        long long result = divide_and_conquer_product(left, depth + 1);
        write(pipefd[1], &result, sizeof(long long));
        close(pipefd[1]);
        exit(0);
    } else if (pid1 < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    // Fork second child for right half
    pid2 = fork();
    if (pid2 == 0) { // Child process 2
        close(pipefd[0]); // Close read end
        ArraySegment right = {
            segment.array,
            segment.start + (segment.end - segment.start) / 2,
            segment.end
        };
        long long result = divide_and_conquer_product(right, depth + 1);
        write(pipefd[1], &result, sizeof(long long));
        close(pipefd[1]);
        exit(0);
    } else if (pid2 < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    // Parent process
    close(pipefd[1]); // Close write end

    // Wait for children and read their results
    waitpid(pid1, NULL, 0);
    waitpid(pid2, NULL, 0);

    read(pipefd[0], &left_product, sizeof(long long));
    read(pipefd[0], &right_product, sizeof(long long));
    close(pipefd[0]);

    return left_product * right_product;
}

int main() {
    int n;
    printf("Enter the number of elements in the array: ");
    scanf("%d", &n);

    // Allocate shared memory for the array
    int *array = mmap(NULL, n * sizeof(int), PROT_READ | PROT_WRITE,
                     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    if (array == MAP_FAILED) {
        perror("mmap");
        exit(EXIT_FAILURE);
    }

    printf("Enter %d integers:\n", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &array[i]);
    }

    ArraySegment full_array = {array, 0, n};
    long long total_product = divide_and_conquer_product(full_array, 0);

    printf("The product of all elements is: %lld\n", total_product);

    // Clean up
    munmap(array, n * sizeof(int));

    return 0;
}

