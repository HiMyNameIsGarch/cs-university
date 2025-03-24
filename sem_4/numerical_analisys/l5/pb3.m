% Plot, in the same figure, the graphs of the function f:[-5,5]->R;
% f(x) = sin(2x) and of the corresponding Hermite interpolation polynomial,
% considering 15 equidistant nodes in [-5, 5]

% function
f = @(x) sin(2*x);

% interval
a = -5;
b = 5;
n = 15;

% equidistant nodes
x = linspace(a, b, n);
