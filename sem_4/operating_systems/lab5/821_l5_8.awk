BEGIN {
    # init vars
    total_sum = 0;
    line1 = 0; # lines with numbers
    line2 = 0; # lines without numbers
}

{
    line_sum = 0;
    has_numbers = 0;

    # iterate over each field in the line
    for (i = 1; i <= NF; i++) {

        # check if the file contains a number
        if ($i ~ /^[0-9]+$/) {
            has_numbers = 1;
            # add the number to the line sum
            line_sum += $i;
        }
    }

    # if the line contains numbers, add the line sum to the total sum
    if (has_numbers) {
        total_sum += line_sum;
        # increment the count of lines with numbers
        line1++;
    } else {
        # otherwise increment the count of the lines without numbers
        line2++;
    }
}

END {
    # print the results in the desired format
    print FILENAME " sum = " total_sum " l1/l2 = " line1 "/" line2;
}
