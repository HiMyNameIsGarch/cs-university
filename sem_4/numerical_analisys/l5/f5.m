% Let f (x) = 3x e^x - e^2x:
f = @(x) 3 * x * exp(x) - exp(2*x);


%--------------------------------< Point a >-----------------------------------
% Approximate f(1,03) by the Hermite interpolation polynomial of degree most 3
% using x_0 = 1 and x_1 = 1,05 and find the absolute error.

% degree
n = 3;
% x's
x = [1, 1.05];



%--------------------------------< Point b >----------------------------------
% Repeat (a) with the Hermite interpolation polynomial of degree at most 5
% using x_0 = 1 and x_1 = 1,05 and x_2 = 1,07 and find the absolute error.


%--------------------------------< Point c >----------------------------------
% Plot the graphs of the function f and of the interpolation polynomials
% from (a) and (b).
