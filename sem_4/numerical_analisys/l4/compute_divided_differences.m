function F_at_x = compute_divided_differences(x, y)
    % arguments:
    %   x - Array of x-values (independent variable).
    %   y - Array of y-values (dependent variable).
    % output:
    %   F_at_x - Divided differences table.

    n = length(x);
    F_at_x = zeros(n, n);
    F_at_x(:, 1) = y'; % First column is the y-values

    % compute the damn table of divided differences
    for j = 2 : n % we start from the second element
        for i = 1 : n - j + 1 % we stop at n - j + 1 because we need to have at least j elements to the right of i
            % plug in the formula
            nominator = F_at_x(i + 1, j - 1) - F_at_x(i, j - 1);
            denominator = x(i + j - 1) - x(i);
            F_at_x(i, j) = nominator / denominator;
        end
    end
end
