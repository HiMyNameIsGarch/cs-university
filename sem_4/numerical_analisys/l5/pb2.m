% With f (x) = ln x, calculate f (1,5) by cubic interpolation, using f(1) = 0,
% f(2) = 0,6931, f'(1) = 1, f'(2) = 0,5. Find the absolute approximation error.

% function
f = @(x) log(x);

% data we know so far
x = [1 2];
y = f(x);
dy = [1, 0.5]; % derivatives at x=1 and x=2

% Hermite interpolation table
z = [x(1), x(1), x(2), x(2)];
f = [y(1), y(1), y(2), y(2)];
f_prime = [dy(1), dy(1), dy(2), dy(2)];

% Divided differences for Hermite interpolation
% First divided differences
f1 = (f(2) - f(1)) / (z(2) - z(1)); % This is f'(1) = 1
f2 = (f(3) - f(2)) / (z(3) - z(2));
f3 = (f(4) - f(3)) / (z(4) - z(3)); % This is f'(2) = 0.5

% Second divided differences
f12 = (f2 - f1) / (z(3) - z(1));
f23 = (f3 - f2) / (z(4) - z(2));

% Third divided difference
f123 = (f23 - f12) / (z(4) - z(1));

% Hermite polynomial coefficients
% P(x) = f(1) + f[1,1](x-1) + f[1,1,2](x-1)^2 + f[1,1,2,2](x-1)^2(x-2)
a = y(1);
b = dy(1);
c = f12;
d = f123;

% Evaluate P(1.5)
x_query = 1.5;
P = a + b*(x_query - 1) + c*(x_query - 1)^2 + d*(x_query - 1)^2*(x_query - 2);

% True value
true_value = log(x_query);

% Absolute error
abs_error = abs(P - true_value);

% Display results
fprintf('Hermite interpolated value at x = 1.5: %.6f\n', P);
fprintf('True value at x = 1.5: %.6f\n', true_value);
fprintf('Absolute error: %.6f\n', abs_error);
