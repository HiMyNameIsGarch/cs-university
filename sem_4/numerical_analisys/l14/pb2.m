% Interval and step size
a = 0;
b = 1;
N = 10;
h = (b - a) / N;

% Nodes
x = a:h:b;

% Preallocate
y_euler = zeros(1, N+1);
y_rk4 = zeros(1, N+1);

% Initial condition
y0 = -1;
y_euler(1) = y0;
y_rk4(1) = y0;

% ODE function
f = @(x, y) 2*x - y;

% Euler's method
for i = 1:N
    y_euler(i+1) = y_euler(i) + h * f(x(i), y_euler(i));
end

% Runge-Kutta 4th order method
for i = 1:N
    k1 = f(x(i), y_rk4(i));
    k2 = f(x(i) + h/2, y_rk4(i) + h*k1/2);
    k3 = f(x(i) + h/2, y_rk4(i) + h*k2/2);
    k4 = f(x(i) + h, y_rk4(i) + h*k3);

    y_rk4(i+1) = y_rk4(i) + h/6 * (k1 + 2*k2 + 2*k3 + k4);
end

% Exact solution
y_exact = exp(-x) + 2*x - 2;

% Plotting
figure;
plot(x, y_euler, 'ro--', 'DisplayName', 'Euler''s Method');
hold on;
plot(x, y_rk4, 'bs-', 'DisplayName', 'Runge-Kutta 4th Order');
plot(x, y_exact, 'k-', 'LineWidth', 1.5, 'DisplayName', 'Exact Solution');
grid on;
xlabel('x');
ylabel('y(x)');
title('ODE Solution using Euler and RK4 Methods');
legend('Location', 'best');
