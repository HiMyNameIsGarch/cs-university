% There are given 5 arbitrary points, using Matlab function ginput: Plot the
% points and the graph of cubic natural spline function that passes through
% all the given points.

% prompt for the user on the graph
fprintf('select 5 points by clicking.\n');
figure;
axis([0 10 0 10]);

% information
title('click to select 5 points');
xlabel('x');
ylabel('y');

grid on;
hold on;

% ginput function to get the points
[x_points, y_points] = ginput(5);

% plot the selected points
plot(x_points, y_points, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
hold on;

% sort the points by x-coordinate
[x_sorted, sort_idx] = sort(x_points);
y_sorted = y_points(sort_idx);

% compute natural cubic spline
natural_spline = spline(x_sorted, y_sorted);

% Evaluate spline over a finer grid for plotting
x_plot = linspace(min(x_sorted), max(x_sorted), 100);
y_plot = ppval(natural_spline, x_plot);

% plot the spline
plot(x_plot, y_plot, 'b-', 'LineWidth', 2);

% add usefull information after the computation
legend('selected points', 'natural cubic spline', 'location', 'best');
title('natural cubic spline through the selected points');
hold off;
