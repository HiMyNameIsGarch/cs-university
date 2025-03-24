% To investigate the relationship between yield of potatoes, y; and level of
% fertilizer, x; an experimenter divided a Öeld into 5 plots of equal size and
% applied di§ering amounts of fertilizer to each. The recorded data are given
% in the table (in pounds).

% x 1  2  3  4  5
% y 22 23 25 30 28

x = [1, 2, 3, 4, 5];
y = [22, 23, 25, 30, 28];

%----------------------------------< Point a >---------------------------------
F = compute_divided_differences(x, y);

x_approx = 2.5;
y_approx = newton_poly(x, F, x_approx);
fprintf("approx yield for %.2f pounds of fertilizer is %.2f pounds.\n", x_approx, y_approx);


%----------------------------------< Point b >---------------------------------

x_vals = linspace(1,5,100);
y_vals = arrayfun(@(t)newton_poly(x, F, t), x_vals);

% plotting
figure

% data points
plot(x, y, "ro", "markersize", 10);
hold on;

% interpolated curve
plot(x_vals, y_vals, "b-", "LineWidth", 2);

% approximation point computed at point a
plot(x_approx, y_approx, 'gs', 'MarkerSize', 10, 'LineWidth', 2);

% information
xlabel("fertilizer")
ylabel("yield")
title("interp of yield vs fertilizer")

grid on;
