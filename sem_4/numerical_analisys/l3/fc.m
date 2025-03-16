% Define the function
f = @(x) cos(x);

% Given nodes
x_nodes = [0, pi/4, pi/3];
y_nodes = f(x_nodes);

% Define the interval
a = -pi/4;
b = pi/2;

% Generate x values for plotting
x_plot = linspace(a, b, 1000);
y_f = f(x_plot);

% Initialize the Lagrange interpolation polynomial values
y_L = zeros(size(x_plot));

% Compute the Lagrange interpolation polynomial using the function
for i = 1:length(x_plot)
    y_L(i) = lagrange_interpolation(x_nodes, y_nodes, x_plot(i));
end

% Plot the results
figure;

plot(x_plot, y_f, 'b-', 'LineWidth', 2); % Original function

hold on;

plot(x_plot, y_L, 'r--', 'LineWidth', 2); % Lagrange interpolation polynomial

plot(x_nodes, y_nodes, 'ko', 'MarkerFaceColor', 'k'); % Nodes

title(' f(x) and lagrange interpolation poly');
legend('f(x)', 'L(x)', 'Nodes');
grid on;
hold off;
