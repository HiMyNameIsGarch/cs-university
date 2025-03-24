function p = aitken_algo(x, f, alpha, epsilon)
    % init Aitken's table
    n = length(x);
    table = zeros(n, n);
    % first column is f(x_i)
    table(:, 1) = f;

    % fill the Aitken's table
    for j = 2:n
        for i = j:n
            % compute the diagonals for the determinant
            diagonal1 = alpha - x(i-j+1) * table(i, j-1);
            diagonal2 = alpha - x(i) * table(i-1, j-1);
            % compute the determinant
            determinant = diagonal1 - diagonal2;
            % compute the denominator
            denominator = x(i) - x(i-j+1);
            % finally put the result in the table
            table(i, j) = determinant / denominator;
        end

        % check the stopping criterion
        if abs(table(j, j) - table(j-1, j-1)) < epsilon
            break;
        end
    end

    % the final approximation is the last diagonal element
    p = table(j, j);
end
