f = @(x)(1 + cos(pi * x))./(1 + 2 * x);

x_interval = 0:0.01:10;
n = 15; % max points
x_nodes = linspace(0, 10, n);
y_nodes = f(x_nodes);

% fill zeros
y_interp = zeros(size(x_interval));

% compute the interpolation at each x point in the defined interval
for k = 1:length(x_interval)
    y_interp(k) = lagrange_interpolation(x_nodes, y_nodes, x_interval(k));
end

% plot time
figure;

% original function
plot(x_interval, f(x_interval), 'b-', 'LineWidth', 2);
hold on;

% lagrange interpolation
plot(x_interval, y_interp, 'r--', 'LineWidth', 2);

% plot the nodes
plot(x_nodes, y_nodes, 'ko', 'MarkerFaceColor', 'k');

title('my lagrange function');

grid on;
hold off;
