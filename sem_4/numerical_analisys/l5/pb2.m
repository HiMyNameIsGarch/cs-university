% With f (x) = ln x, calculate f (1,5) by cubic interpolation, using f(1) = 0,
% f(2) = 0,6931, f'(1) = 1, f'(2) = 0,5. Find the absolute approximation error.

% function
f = @(x) log(x);

% data we know so far
x = [1 2];
y = f(x);
