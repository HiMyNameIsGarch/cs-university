% data
time = 1:7; % 1 to 7 hours
temperature = [13, 15, 20, 14, 15, 13, 10];

% data points
n = length(time);

% normal equations
sum_x = sum(time);
sum_y = sum(temperature);
sum_xy = sum(time .* temperature);
sum_x2 = sum(time.^2);

% normal equations for a and b
A = [sum_x2, sum_x; sum_x, n];
B = [sum_xy; sum_y];
coefficients = A \ B;

a = coefficients(1);
b = coefficients(2);

% linear function
phi = @(x) a*x + b;

% predict temperature at 8:00 when x is 8
prediction_8am = phi(8);

% minimum error E(a,b)
E = sum((temperature - phi(time)).^2);

% display results
fprintf('best line: phi(x) = %.4f*x + %.4f\n', a, b);
fprintf('predicted temp at 8:00: %.4f\n', prediction_8am);
fprintf('min err E(a,b): %.4f\n', E);

% plot
figure;

% data points
plot(time, temperature, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
hold on;

% plot the fitted line
x_vals = linspace(1, 8, 100);

% fitted line
plot(x_vals, phi(x_vals), 'r-', 'LineWidth', 2);

% prediction point
plot(8, prediction_8am, 'gs', 'MarkerFaceColor', 'g', 'MarkerSize', 10);

% information
xlabel('time (1:00=1, 2:00=2, ..., 8:00=8)');
ylabel('temperatur');
title('linear least squares approximation of room temperature');
legend('data points', 'fitted line', '8:00 prediction', 'location', 'best');
grid on;
hold off;
