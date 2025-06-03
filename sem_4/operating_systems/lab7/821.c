#include <stdio.h> // standard input and output operations
#include <stdlib.h> // for exit
#include <string.h> // string operations for lengths of the files

/*
Write a C Program that receives as command line arguments two file names and
merges the lines of the two files(that are already sorted)
*/

/*
My approach to this problem is to read the two files line by line and
compare the lines with the standard function strcmp. The smaller line is
written to the output file. The process is repeated until one of the files
pointer is null, then the rest of the lines are written to the output.
*/

void  merge_files(FILE *file1, FILE *file2, FILE *output){
    // store the lines of the two files as pointers
    char *line1 = NULL;
    char *line2 = NULL;

    //  unsigned long data type for length of the files
    size_t len1 = 0, len2 = 0;

    // long data type for the read lines
    ssize_t read1, read2;

    // inital read of the 2 files
    read1 = getline(&line1, &len1, file1);
    read2 = getline(&line2, &len2, file2);

    while(read1 != -1 && read2 != -1) {
        // compare the lines and write the smaller one to the output
        if (strcmp(line1, line2) <= 0 ) {
            // write the lien to the output and check for errors
            if(fputs(line1, output) == EOF) {
                perror("Error writing to output");
                return;
            }
            // read the nest file from the file1
            read1 = getline(&line1, &len1, file1);
        } else {
            // write the line to the output and check for errors
            if(fputs(line2, output) == EOF) {
                perror("Error writing to output");
                return;
            }
            // read the next file from the file2
            read2 = getline(&line2, &len2, file2);
        }
    }

    // finally copy the remaining lines from the files
    while(read1 != -1) {
        // also check for errors while trying to write to the output
        if (fputs(line1, output) == EOF) {
            perror("Error writing to output");
            return;
        }
        // read the next line from file1
        read1 = getline(&line1, &len1, file1);
    }

    // copy the remaining lines from file2
    while(read2 != -1) {
        // also check for errors while trying to write to the output
        if (fputs(line2, output) == EOF) {
            perror("Error writing to output");
            return;
        }
        // read the next line from file2
        read2 = getline(&line2, &len2, file2);
    }

    // free the allocated memory ( throw your trash Java people )
    free(line1);
    free(line2);

}

int main(int argc, char *argv[]) {
    // basic argument check
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <file1> <file2>\n", argv[0]);
        return EXIT_FAILURE;
    }

    // open the first file
    FILE *file1 = fopen(argv[1], "r");
    if (!file1) {
        fprintf(stderr, "Error opening first file (%s): ", argv[1]);
        perror("");
        // don't forget to close the file
        fclose(file1);
        return EXIT_FAILURE;
    }

    // open the second file
    FILE *file2 = fopen(argv[2], "r");
    // check if the file was opened successfully
    if (!file2) {
        fprintf(stderr, "Error opening second file (%s): ", argv[2]);
        perror("");
        // don't forget to close the file if it was opened
        fclose(file2);
        return EXIT_FAILURE;
    }

    // call the merge function for the two files
    merge_files(file1, file2, stdout);

    // close the files
    fclose(file1);
    fclose(file2);

    return EXIT_SUCCESS;
}
