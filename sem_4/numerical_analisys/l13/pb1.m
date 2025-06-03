% DO NOT RUN, THIS HAS A BUG IN IT, INFINITE LOOP
format long

% Given data
alpha = 0.5671432; % known solution
x0 = 0.5;
epsilon = 1e-10;

% Define iteration functions as function handles
g1 = @(x) exp(-x);
g2 = @(x) (1 + x) / (exp(x) + 1);
g3 = @(x) x + 1 - x * exp(x);


% Call fixed point for each g
[x1, iter1] = fixed_point(g1, x0, epsilon);
[x2, iter2] = fixed_point(g2, x0, epsilon);
[x3, iter3] = fixed_point(g3, x0, epsilon);

% Display results
fprintf('Method 1: x = %.12f, iterations = %d\n', x1, iter1);
fprintf('Method 2: x = %.12f, iterations = %d\n', x2, iter2);
fprintf('Method 3: x = %.12f, iterations = %d\n', x3, iter3);

% Fixed point iteration function
function [x_approx, iter] = fixed_point(g, x0, tol)
    iter = 0;
    x_old = x0;
    while true
        x_new = g(x_old);
        iter = iter + 1;
        if abs(x_new - x_old) < tol
            break;
        end
        x_old = x_new;
        if iter > 1e5
            warning('Too many iterations');
            break;
        end
    end
    x_approx = x_new;
end
