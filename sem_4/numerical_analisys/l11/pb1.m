% define the system matrix a and vector b from the problem
a = [1 1 1 1;
     2 3 1 5;
     -1 1 -5 3;
     3 1 7 -2];
b = [10; 31; -2; 18];

% call the gauss partial pivoting function
x = gauss_partial_pivoting(a, b);

% display the solution
disp('solution using Gauss method:');
disp(x);

% function implementing gauss method with partial pivoting
function x = gauss_partial_pivoting(a, b)
    % get system size
    n = size(a, 1);

    % perform forward elimination with partial pivoting
    for p = 1:n-1
        % find the row with maximum absolute value in current column
        [max_val, q] = max(abs(a(p:n, p)));
        q = q + p - 1; % adjust index for subarray

        % check for singular matrix
        if a(q, p) == 0
            error('matrix is singular or nearly singular');
        end

        % swap rows if necessary
        if q ~= p
            a([p q], :) = a([q p], :);
            b([p q]) = b([q p]);
        end

        % perform elimination for rows below p
        for k = p+1:n
            factor = a(k, p) / a(p, p);
            a(k, p:n) = a(k, p:n) - factor * a(p, p:n);
            b(k) = b(k) - factor * b(p);
        end
    end

    % check if last pivot is zero
    if a(n, n) == 0
        error('matrix is singular - no unique solution');
    end

    % perform back substitution
    x = zeros(n, 1);
    for i = n:-1:1
        x(i) = (b(i) - a(i, i+1:n) * x(i+1:n)) / a(i, i);
    end
end
