% Problem 5: Evaluate integral using repeated Simpson's rule

% Define the integrand
f = @(x) 1./(4 + sin(20*x));

% Integration limits
a = 0;
b = pi;

% Compute for n=10 and n=30
n1 = 10;
n2 = 30;

I10 = simpson_comp(f, a, b, n1);
I30 = simpson_comp(f, a, b, n2);

% Display results
fprintf('Approximation with n=%d: %.7f\n', n1, I10);
fprintf('Approximation with n=%d: %.7f\n', n2, I30);
fprintf('Expected result: 0.8111579\n');

% Error analysis
exact = 0.8111579;
err10 = abs(I10 - exact);
err30 = abs(I30 - exact);

fprintf('\nError analysis:\n');
fprintf('n=%d error: %.2e\n', n1, err10);
fprintf('n=%d error: %.2e\n', n2, err30);

% Plot the integrand to show oscillatory nature
x_plot = linspace(a, b, 1000);
y_plot = f(x_plot);

figure;
plot(x_plot, y_plot, 'b-', 'LineWidth', 1.5);
xlabel('x');
ylabel('f(x)');
title('Integrand: 1/(4 + sin(20x))');
grid on;

% Function for composite Simpson's rule
function I = simpson_comp(f, a, b, n)
    h = (b - a)/n;
    x = a:h:b;
    y = f(x);
    I = h/3 * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));
end

