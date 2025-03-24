% nodes ( that are perfect squares around the point )
x = [100; 121; 144];

% function
f = sqrt(x);

% the point to approixmate
alpha = 115;
epsilon = 1e-3;


% init Aitken's table
n = length(x);
table = zeros(n, n);
% first column
table(:, 1) = f;

% start using the aitken's algorithm
for j = 2:n
    for i = j:n
        % the determinant of the matrix
        diag1 = table(i, j - 1) * (alpha - x(i - j + 1) );
        diag2 = table(i-1, j - 1) * (alpha - x(i));
        nominator = diag1 - diag2;
        % 1 / x_i - x_j
        denominator = x(i) - x(i - j + 1);
        table(i, j) = nominator / denominator;
    end

    % check the stopping for the precision
    if abs(table(j, j) - table(j-1, j-1)) < epsilon
        break;
    end
end

% the approximation is the last element of the last column
sqrt_approx = table(j, j);
E = abs(sqrt_approx - sqrt(115));

% results
fprintf('approx of sqrt(115): %.6f\n', sqrt_approx);
fprintf('the error is: %.6f\n', E);
