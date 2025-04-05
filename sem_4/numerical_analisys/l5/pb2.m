% With f (x) = ln x, calculate f (1,5) by cubic interpolation,
% using f(1) = 0, f(2) = 0.6931, f'(1) = 1, f'(2) = 0.5.
% Find the absolute approximation error.

% data
x_nodes = [1, 1, 2, 2];
f_values = [0, 0, 0.6931, 0.6931];
df_values = [1, 0.6931, 0.5, NaN];

% points
n = length(x_nodes);

% div diff
F = compute_divided_differences(x_nodes, f_values, df_values);

coeffs = F(1,:);
x_eval = 1.5;

% Simplified evaluation of the interpolation polynomial
h1 = x_eval - x_nodes(1);
h2 = x_eval - x_nodes(2);
h3 = x_eval - x_nodes(3);

term1 = coeffs(1);
term2 = coeffs(2) * h1;
term3 = coeffs(3) * h1 * h2;
term4 = coeffs(4) * h1 * h2 * h3;

result = term1 + term2 + term3 + term4;

% True value and error
true_value = log(1.5);
error = abs(result - true_value);

% Display results
fprintf('hermite interpolation at x = 1.5: %.6f\n', result);
fprintf('value of ln(1.5): %.6f\n', true_value);
fprintf('absolute approx error: %.6f\n', error);

% Plot the interpolation
x_plot = linspace(0.5, 2.5, 100);
y_plot = zeros(size(x_plot));
for k = 1:length(x_plot)
    h1_plot = x_plot(k) - x_nodes(1);
    h2_plot = x_plot(k) - x_nodes(2);
    h3_plot = x_plot(k) - x_nodes(3);

    y_plot(k) = coeffs(1) + coeffs(2) * h1_plot + ...
                coeffs(3) * h1_plot * h2_plot + ...
                coeffs(4) * h1_plot * h2_plot * h3_plot;
end

% plot
figure;

% original function
plot(x_plot, log(x_plot), 'b-', 'LineWidth', 1.5)
hold on

% hermite interpolation
plot(x_plot, y_plot, 'r--', 'LineWidth', 1.5)
plot(x_nodes(1:2:end), f_values(1:2:end), 'ro', 'MarkerFaceColor', 'r')  % Original nodes

% information
title('cubic Hermite Interpolation of ln(x)');
xlabel('x');
ylabel('f(x)');

grid on;
