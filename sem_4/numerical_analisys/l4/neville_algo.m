function result = neville_algo(x, y, x_eval)
    n = length(x);
    Q = zeros(n, n);
    Q(:, 1) = y'; % First column is the y-values

    for i = 2:n
        for j = 2:i
            % diagonals of determinant
            diag1 = (x_eval - x(i-j+1)) * Q(i, j-1);
            diag2 = (x_eval - x(i)) * Q(i-1, j-1);
            % calculate the determinant
            determinant = diag1  - diag2;
            % calculate the denominator
            denominator = x(i) - x(i-j+1);
            % calculate the Q value
            Q(i, j) = determinant / denominator;
        end
    end

    result = Q(n, n); % The final interpolated value
end
