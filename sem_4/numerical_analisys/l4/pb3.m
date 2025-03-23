% Consider the function f:[0, 6] -> R; f (x) = e^sin x and 13 equidistant in-
% terpolation points. Plot the interpolation points, the function f and the
% Newton intepolation polynomial N_12f

% function
f = @(x) exp(sin(x));

% interval
a = 0;
b = 6;

% number of equidistant points
n = 13;

% interpolation points
x = linspace(a, b, n);
y = f(x);

% divided differences
F = compute_divided_differences(x, y);

% smooth the plot with 1000 points
x_vals = linspace(a, b, 1000);
% real values
y_vals = arrayfun(@(t) newton_poly(x, F, t), x_vals);

% plot
figure;

% original function
plot(x_vals, f(x_vals), 'k-', "LineWidth", 2);
hold on;

% interpolation points
plot(x, y, 'ro', "MarkerSize", 10);

% newton polynomial
plot(x_vals, y_vals, 'b--', 'LineWidth', 2);

% information
xlabel('x');
ylabel('f(x)');
title('newton interpolation polynomial');
grid on;
