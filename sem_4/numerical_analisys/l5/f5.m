% Let f (x) = 3x e^x - e^2x:
f = @(x) 3 * x .* exp(x) - exp(2*x);
df = @(x) 3 * exp(x) + 3 * x .* exp(x) - 2 * exp(2*x);

%--------------------------------< Point a >-----------------------------------
% Approximate f(1,03) by the Hermite interpolation polynomial of degree most 3
% using x_0 = 1 and x_1 = 1,05 and find the absolute error.

x_nodes_a = [1, 1, 1.05, 1.05];
f_values_a = [f(1), f(1), f(1.05), f(1.05)];
df_values_a = [df(1), df(1), df(1.05), df(1.05)];

F_a = compute_divided_differences(x_nodes_a, f_values_a, df_values_a);
approx_a = evaluate_poly(1.03, F_a, x_nodes_a);
true_value = f(1.03);
abs_error_a = abs(true_value - approx_a);

fprintf('A - hermite (deg <= 3) approx at x=1.03: %.8f\n', approx_a);
fprintf('true value: %.8f\n', true_value);
fprintf('abs err: %.8f\n\n', abs_error_a);


%--------------------------------< Point b >----------------------------------
% Repeat (a) with the Hermite interpolation polynomial of degree at most 5
% using x_0 = 1 and x_1 = 1,05 and x_2 = 1,07 and find the absolute error.

x_nodes_b = [1, 1, 1.05, 1.05, 1.07, 1.07];  % Repeated for derivatives
f_values_b = [f(1), f(1), f(1.05), f(1.05), f(1.07), f(1.07)];
df_values_b = [df(1), df(1), df(1.05), df(1.05), df(1.07), df(1.07)];

F_b = compute_divided_differences(x_nodes_b, f_values_b, df_values_b);
approx_b = evaluate_poly(1.03, F_b, x_nodes_b);
abs_error_b = abs(true_value - approx_b);

fprintf('B - Hermite (deg <= 5) approx at x=1.03: %.8f\n', approx_b);
fprintf('true value: %.8f\n', true_value);
fprintf('abs err: %.8f\n\n', abs_error_b);


%--------------------------------< Point c >----------------------------------
% Plot the graphs of the function f and of the interpolation polynomials
% from (a) and (b).

x_plot = linspace(0.95, 1.1, 100);
y_true = f(x_plot);

% evaluate polynomials over the plot range
y_approx_a = arrayfun(@(x) evaluate_poly(x, F_a, x_nodes_a), x_plot);
y_approx_b = arrayfun(@(x) evaluate_poly(x, F_b, x_nodes_b), x_plot);

figure;

% orignal function
plot(x_plot, y_true, 'k-', 'LineWidth', 2, 'DisplayName', 'f(x) = 3x e^x - e^{2x}');
hold on;

% hermite approximations
plot(x_plot, y_approx_a, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Hermite (deg ≤ 3)');

% 5th degree hermite
plot(x_plot, y_approx_b, 'r-.', 'LineWidth', 1.5, 'DisplayName', 'Hermite (deg ≤ 5)');

% interpolation nodes
scatter([1, 1.05, 1.07], f([1, 1.05, 1.07]), 50, 'g', 'filled', 'DisplayName', 'Interpolation Nodes');

% information
title('hermite Interpolation of f(x) = 3x e^x - e^{2x}');
xlabel('x');
ylabel('f(x)');

grid on;
hold off;
