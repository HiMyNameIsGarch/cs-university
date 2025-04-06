% consider the function f(x) = cos(x), and the nodes x = 0 : pi/4 : 2pi and
% the linear polynomial spline
% p_i(x) = f(x_i) + (f(x_(i+1) - f(x_i)))/(x_(i+1) - x_i)*(x - x_i) on each
% interval [x_i, x_(i+1)]. Plot in the same figure, the graph of the function
% and of the corresponding linear spline function.

% function
f = @(x) cos(x);

% nodes
x_nodes = 0 : pi/4 : 2 * pi;
y_nodes = f(x_nodes);

% num of intervals - 1
n = length(x_nodes) - 1;

% plotting
x_fine = linspace(0, 2*pi, 1000);
y_fine = f(x_fine);

% figure
figure;
hold on;

% plot the function
plot(x_fine, y_fine, 'b-', 'LineWidth', 2, 'DisplayName', "cos(x)");

for i = 1:n
    % plot the linear spline
    x_interval = linspace(x_nodes(i), x_nodes(i+1),2);
    % slope
    slope = (y_nodes(i+1) - y_nodes(i)) / (x_nodes(i+1) - x_nodes(i));
    % linear spline
    y_interval = y_nodes(i) + slope * (x_interval - x_nodes(i));
    % final plot of the linear spline
    plot(x_interval, y_interval, 'r-', 'LineWidth', 2, 'DisplayName', "spline no " + i);
end

% plot the nodes
plot (x_nodes, y_nodes, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', "nodes");

% information
xlabel('x');
ylabel('f(x)');
title('Linear Spline Approximation of cos(x)');
legend('show', 'Location', 'best');
grid on;
hold off
