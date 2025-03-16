f = @(x) cos(x);

% nodes
x_nodes = [0, pi/4, pi/3];
y_nodes = f(x_nodes);

% interval
a = -pi/4;
b = pi/2;
x_plot = linspace(a, b, 1000);

% plot time
figure;

for i = 1:length(x_nodes)
    % compute l_i(x)
    l_i = @(x) prod((x - x_nodes([1:i-1, i+1:end])) / prod((x_nodes(i) - x_nodes([1:i-1, i+1:end]))));

    % get y values
    y_plot = arrayfun(l_i, x_plot);

    % plot l_i(x)
    subplot(2, 2, i);
    plot(x_plot, y_plot, 'LineWidth', 2);

    % info
    title(sprintf('Fundamental Polynomial l_%d(x)', i-1));
    grid on;
end
