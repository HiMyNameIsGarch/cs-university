% Define the function
f = @(x) cos(x);

% Given nodes
x_nodes = [0, pi/4, pi/3];
y_nodes = f(x_nodes);

% Interval for plotting
x_interval = linspace(-pi/4, pi/2, 1000);

% Task 1: Plot the fundamental Lagrange polynomials
figure;
hold on;
for i = 1:length(x_nodes)
    % Compute the fundamental polynomial l_i(x)
    l_i = @(x) prod((x - x_nodes([1:i-1, i+1:end])) ./ prod(x_nodes(i) - x_nodes([1:i-1, i+1:end])));
    % Plot l_i(x)
    plot(x_interval, arrayfun(l_i, x_interval), 'LineWidth', 2, 'DisplayName', sprintf('l_%d(x)', i-1));
end
xlabel('x');
ylabel('l_i(x)');
title('Fundamental Lagrange Polynomials');
legend show;
grid on;
hold off;

% Task 2: Compute the value of the Lagrange interpolation polynomial at x = pi/6
x_interp = pi/6;

% Classical formula
L_classical = 0;
for i = 1:length(x_nodes)
    l_i = prod((x_interp - x_nodes([1:i-1, i+1:end])) ./ prod(x_nodes(i) - x_nodes([1:i-1, i+1:end])));
    L_classical = L_classical + l_i * y_nodes(i);
end

% Barycentric formula
w = zeros(1, length(x_nodes));
for j = 1:length(x_nodes)
    w(j) = 1 / prod(x_nodes(j) - x_nodes([1:j-1, j+1:end]));
end
L_barycentric = sum(w .* y_nodes ./ (x_interp - x_nodes)) / sum(w ./ (x_interp - x_nodes));

fprintf('Classical Formula: L(pi/6) = %.6f\n', L_classical);
fprintf('Barycentric Formula: L(pi/6) = %.6f\n', L_barycentric);

% Task 3: Plot the function and the Lagrange interpolation polynomial
y_interp = zeros(size(x_interval));
for k = 1:length(x_interval)
    y_interp(k) = lagrange_interpolation(x_nodes, y_nodes, x_interval(k));
end

figure;
plot(x_interval, f(x_interval), 'b-', 'LineWidth', 2); % Original function
hold on;
plot(x_interval, y_interp, 'r--', 'LineWidth', 2); % Lagrange interpolation
plot(x_nodes, y_nodes, 'ko', 'MarkerFaceColor', 'k'); % Interpolation nodes
xlabel('x');
ylabel('f(x)');
title('Function f(x) and Lagrange Interpolation Polynomial');
legend('f(x)', 'Lagrange Interpolation', 'Interpolation Nodes');
grid on;
hold off;

% Task 4: Two other sets of nodes
% Set 1: Equally spaced nodes
x_nodes_set1 = linspace(-pi/4, pi/2, 4);
y_nodes_set1 = f(x_nodes_set1);

% Set 2: Chebyshev nodes
n = 3; % Number of nodes
x_nodes_set2 = ((pi/2 + pi/4)/2 + (pi/2 - (-pi/4))/2 * cos((2*(0:n-1) + 1) * pi / (2*n)));
y_nodes_set2 = f(x_nodes_set2);

% Plot for Set 1
y_interp_set1 = zeros(size(x_interval));
for k = 1:length(x_interval)
    y_interp_set1(k) = lagrange_interpolation(x_nodes_set1, y_nodes_set1, x_interval(k));
end

figure;
plot(x_interval, f(x_interval), 'b-', 'LineWidth', 2); % Original function
hold on;
plot(x_interval, y_interp_set1, 'r--', 'LineWidth', 2); % Lagrange interpolation
plot(x_nodes_set1, y_nodes_set1, 'ko', 'MarkerFaceColor', 'k'); % Interpolation nodes
xlabel('x');
ylabel('f(x)');
title('Function f(x) and Lagrange Interpolation (Set 1: Equally Spaced)');
legend('f(x)', 'Lagrange Interpolation', 'Interpolation Nodes');
grid on;
hold off;

% Plot for Set 2
y_interp_set2 = zeros(size(x_interval));
for k = 1:length(x_interval)
    y_interp_set2(k) = lagrange_interpolation(x_nodes_set2, y_nodes_set2, x_interval(k));
end

figure;
plot(x_interval, f(x_interval), 'b-', 'LineWidth', 2); % Original function
hold on;
plot(x_interval, y_interp_set2, 'r--', 'LineWidth', 2); % Lagrange interpolation
plot(x_nodes_set2, y_nodes_set2, 'ko', 'MarkerFaceColor', 'k'); % Interpolation nodes
xlabel('x');
ylabel('f(x)');
title('Function f(x) and Lagrange Interpolation (Set 2: Chebyshev)');
legend('f(x)', 'Lagrange Interpolation', 'Interpolation Nodes');
grid on;
hold off;

% Lagrange interpolation function
function y_interp = lagrange_interpolation(x, y, x_interp)
    n = length(x);
    y_interp = 0;
    for i = 1:n
        L = 1;
        for j = 1:n
            if j ~= i
                L = L * (x_interp - x(j)) / (x(i) - x(j));
            end
        end
        y_interp = y_interp + y(i) * L;
    end
end
