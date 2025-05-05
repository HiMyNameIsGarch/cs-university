%-----------------------------------< Point a >--------------------------------
% approximate the integral using the trapezium formula
f = @(x) 2 ./ (1 + x.^2);
a = 0;
b = 1;
I_trapezium = (b - a) * (f(a) + f(b)) / 2;
fprintf('approx using trapezium formula: %.8f\n', I_trapezium);

%-----------------------------------< Point b >--------------------------------
% plot the function and the trapezium
x = linspace(0, 1, 100);
y = f(x);
vertices_x = [0, 0, 1, 1, 0];
vertices_y = [0, f(0), f(1), 0, 0];

figure;
plot(x, y, 'b-', 'LineWidth', 2); hold on;
plot(vertices_x, vertices_y, 'r--', 'LineWidth', 1.5);
fill(vertices_x, vertices_y, 'r', 'FaceAlpha', 0.2);
xlabel('x');
ylabel('f(x)');
title('func f(x) = 2/(1+x^2) and trapezium area');
legend('f(x)', 'trapezium', 'Location', 'best');
grid on;
hold off;

%-----------------------------------< Point c >--------------------------------
% approximate the integral using simpson's formula
I_simpson = (b - a) / 6 * (f(a) + 4*f((a + b)/2) + f(b));
fprintf('approx using Simpson''s formula: %.8f\n', I_simpson);
