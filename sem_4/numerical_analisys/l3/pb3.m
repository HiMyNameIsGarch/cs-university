% the function
f = @(x)(1 + cos(pi * x))./(1 + 2 * x);

% interval
x_interval = linspace(0, 10, 1000);

n = 15; % equally spaced points
x_nodes = linspace(0, 10, n);
y_nodes = f(x_nodes);% the x nodes evaluated at the function f(x)

y_interp = zeros(size(x_interval));
for k = 1:length(x_interval) % compute the interpolation at each x point in the defined interval
    y_interp(k) = lagrange_interpolation(x_nodes, y_nodes, x_interval(k));
end

% plot time
figure;
plot(x_interval, f(x_interval), 'b-', 'LineWidth', 2);
hold on;
plot(x_interval, y_interp, 'r--', 'LineWidth', 2);
plot(x_nodes, y_nodes, 'ko', 'MarkerFaceColor', 'k');
title('my lagrange function');
grid on;
hold off;

function y_interp = lagrange_interpolation(x, y, x_interp)
    n = length(x);
    y_interp = 0;
    for i = 1:n
        L = 1;
        for j = 1:n
            if j ~= i % trivial formula from course
                L = L * (x_interp - x(j)) / (x(i) - x(j));
            end
        end % the exact same function as the exercise before this
        y_interp = y_interp + y(i) * L;
    end
end
