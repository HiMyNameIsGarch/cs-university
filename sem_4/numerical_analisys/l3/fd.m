f = @(x) cos(x);

% interval boundaries
a = -pi/4;
b = pi/2;

% first set of nodes
x_nodes1 = [-pi/4, pi/8, pi/2];
y_nodes1 = f(x_nodes1);

% second set of nodes
x_nodes2 = [-pi/6, pi/12, pi/3];
y_nodes2 = f(x_nodes2);

% x values for plotting
x_plot = linspace(a, b, 1000);
y_f = f(x_plot);

% zero initialization
y_L1 = zeros(size(x_plot));
y_L2 = zeros(size(x_plot));

% compute the lagrange interpolation
for i = 1:length(x_plot)
    y_L1(i) = lagrange_interpolation(x_nodes1, y_nodes1, x_plot(i));
    y_L2(i) = lagrange_interpolation(x_nodes2, y_nodes2, x_plot(i));
end

% plotting
figure;

% -----------------------------< FIRST set of points >----------------------------
subplot(2, 1, 1);

% original function
plot(x_plot, y_f, 'b-', 'LineWidth', 2);
hold on;

% lagrange for set 1
plot(x_plot, y_L1, 'g--', 'LineWidth', 2);

% first set of nodes
plot(x_nodes1, y_nodes1, 'ko', 'MarkerFaceColor', 'k');

% info
title('f(x) and Lagrange for set 1');
legend('f(x)', 'L_1(x)', 'Nodes');

grid on;
hold off;

% ----------------------------< SECOND set of points >----------------------------
subplot(2, 1, 2);

% original function
plot(x_plot, y_f, 'b-', 'LineWidth', 2);
hold on;

% lagrange for set 2
plot(x_plot, y_L2, 'm--', 'LineWidth', 2);

% second set of nodes
plot(x_nodes2, y_nodes2, 'ko', 'MarkerFaceColor', 'k');

% info
title('f(x) and lagrange for set 2');
legend('f(x)', 'L_2(x)', 'Nodes');

grid on;
hold off;
