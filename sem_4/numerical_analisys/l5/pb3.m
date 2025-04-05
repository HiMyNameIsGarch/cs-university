% Plot, in the same figure, the graphs of the function f:[-5,5]->R;
% f(x) = sin(2x) and of the corresponding Hermite interpolation polynomial,
% considering 15 equidistant nodes in [-5, 5]

% init data
f = @(x) sin(2*x);
df = @(x) 2*cos(2*x);

n_original = 15;
x_original = linspace(-5, 5, n_original);

% double the nodes
x_nodes = repelem(x_original, 2);

% function values and derivatives at nodes
f_values = repelem(f(x_original), 2);
df_values = zeros(size(x_nodes));
df_values(1:2:end) = df(x_original);

% div diff
F = compute_divided_differences(x_nodes, f_values, df_values);
% disp(F);

% Hermite polynomial evaluation function
hermite_poly = @(x) arrayfun(@(x_eval) evaluate_poly(x_eval, F, x_nodes), x);

% Create evaluation points
x_plot = linspace(-5, 5, 500);
y_true = f(x_plot);
y_interp = hermite_poly(x_plot);

% plot
figure;

% original function
plot(x_plot, y_true, 'b-', 'LineWidth', 2); hold on;

% hermite interpolation
plot(x_plot, y_interp, 'r--', 'LineWidth', 1.5);

% original nodes
plot(x_original, f(x_original), 'ko', 'MarkerFaceColor', 'k');
% interpolated nodes
ylim([-1.5, 1.5]);

% information
title('hermite Interpolation of sin(2x)');
xlabel('x');
ylabel('f(x)');

grid on;
