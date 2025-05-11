% define the matrix a and vector b from the problem
a = [6 2 1 -1;
     2 4 1 0;
     1 1 4 -1;
     -1 0 -1 3];
b = [8; 7; 5; 1];

% perform lu decomposition using doolittle method
[L, U] = doolittle_lu(a);

% display the decomposition
disp('lower triangular matrix L:');
disp(L);
disp('upper triangular matrix U:');
disp(U);

% verify the decomposition
disp('verification (L*U should equal A):');
disp(L*U);

% solve the system using the lu decomposition
x = solve_lu_system(L, U, b);

% display the solution
disp('solution using DooLittle method x:');
disp(x);

% function for lu decomposition using doolittle method
function [L, U] = doolittle_lu(a)
    n = size(a, 1);
    L = eye(n); % initialize L as identity matrix
    U = zeros(n); % initialize U as zero matrix

    for k = 1:n
        % compute upper triangular matrix elements
        U(k, k:n) = a(k, k:n) - L(k, 1:k-1) * U(1:k-1, k:n);

        % compute lower triangular matrix elements (below diagonal)
        for j = k+1:n
            L(j, k) = (a(j, k) - L(j, 1:k-1) * U(1:k-1, k)) / U(k, k);
        end
    end
end

% function to solve system using lu decomposition
function x = solve_lu_system(L, U, b)
    n = length(b);

    % forward substitution for Ly = b
    y = zeros(n, 1);
    for i = 1:n
        y(i) = b(i) - L(i, 1:i-1) * y(1:i-1);
    end

    % backward substitution for Ux = y
    x = zeros(n, 1);
    for i = n:-1:1
        x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
    end
end
