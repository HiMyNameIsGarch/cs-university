#!/bin/sh

# Write a shell script which takes as parameters two names of text files. The
# script will compare the two text files line by line and display the first 3
# text lines that differ.

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file1> <file2>"
    exit 1
fi

file1="$1"
file2="$2"

# Check if both files exist
if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
    echo "Error: One or both files do not exist."
    exit 1
fi

# Initialize a counter for differing lines
diff_count=0

# Use a while loop to read both files line by line
while IFS= read -r line1 && IFS= read -r line2 <&3; do
    if [ "$line1" != "$line2" ]; then
        diff_count=$((diff_count + 1))
        echo "Difference $diff_count:"
        echo "< $line1"
        echo "> $line2"
        echo "-------------------------"
        if [ "$diff_count" -eq 3 ]; then
            break
        fi
    fi
done < "$file1" 3< "$file2"

# If no differences were found
if [ "$diff_count" -eq 0 ]; then
    echo "The files are identical."
fi
