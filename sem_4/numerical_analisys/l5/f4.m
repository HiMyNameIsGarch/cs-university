% The data from the following table are generated
% using the function f(x)= x lnx:

%  x      f(x)       f'(x)
% 8,3   17,56492   3,116256
% 8,6   18,50515   3,151762

% Use the Hermite interpolation polynomial to approximate f(8,4)
% and find the absolute error.

% function
f = @(x) x * log10(x);

% values from table
x = [8.3, 8.6];
fx = [17.56492, 18.50515];
dfx = [3.116256, 3.151762];
