% Consider the function f:[-5, 5]->R; f (x) = sin x and 20 equidistant
% interpolation points. Plot the interpolation points, the function f and the La-
% grange intepolation polynomial obtained using Aitkenís algorithm with precision
% epsilon = 10^-3:
% base function
f = @(x) sin(x);

% interval
a = -5;
b = 5;

% nr of interpolation points
n = 20;

% equidistant interpolation points
x_interp = linspace(a, b, n);

% function values at interpolation points
f_interp = sin(x_interp);

% precision
epsilon = 1e-3;

% Generate points for plotting the original function and the interpolation polynomial
x_plot = linspace(a, b, 1000);
f_plot = f(x_plot);
p_plot = zeros(size(x_plot));

% lagrange interp poly using Aitken's algorithm
for i = 1:length(x_plot)
    p_plot(i) = aitken_algo(x_interp, f_interp, x_plot(i), epsilon);
end

% plot
figure;

% interpolation points
plot(x_interp, f_interp, 'ro');
hold on;

% original function
plot(x_plot, f_plot, 'b-');
% lagrange interpolation polynomial
plot(x_plot, p_plot, 'g--');

% information
xlabel('x');
ylabel('f(x)');
title('lagrange interp using aitkens algo');

grid on;
hold off;

