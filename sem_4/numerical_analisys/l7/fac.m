% degree of approx poly
n = 4;

% No of points - 1
m = 11;

% interval
a = 0; b = 10;

% gen 12 random points in [0,10]
rng('default'); % For reproducibility

% sort them to plot better
x_points = sort(a + (b-a)*rand(12,1));

% func vals at these points
f_points = exp(x_points);

% the normal equations
% basis functions are 1, x, x^2, ..., x^n
A = zeros(n+1, n+1);
b_vec = zeros(n+1, 1);

% normal equation matrix and vector
for i = 1:n+1
    for k = 1:n+1
        % <g_i,g_k> = sum_{j=1}^12 x_j^(i-1) * x_j^(k-1) = sum x_j^(i+k-2)
        A(i,k) = sum(x_points.^(i+k-2));
    end
    % <f,g_i> = sum_{j=1}^12 f(x_j) * x_j^(i-1)
    b_vec(i) = sum(f_points .* x_points.^(i-1));
end

% solve the system for coefficients a_i
coefficients = A \ b_vec;

% approx poly func
phi = @(x) polyval(flipud(coefficients), x);

% plot
x_plot = linspace(a, b, 500);
figure;
hold on;

% original function
plot(x_plot, exp(x_plot), 'b-', 'LineWidth', 2, 'DisplayName', 'f(x) = e^x');

% approximation
plot(x_plot, phi(x_plot), 'r--', 'LineWidth', 2, 'DisplayName', sprintf('degree %d approx', n));

% random points
plot(x_points, f_points, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6, 'DisplayName', 'sample points');

% information
xlabel('x');
ylabel('f(x)');
title(sprintf('least squares approximation of e^x (degree %d)', n));
legend('Location', 'northwest');

grid on;
hold off;

% display the polynomial
fprintf('least squares approximating polynomial of degree %d is:\n', n);
for i = 1:n+1
    power = n+1-i;
    if power > 1
        fprintf(' + %.4f*x^%d', coefficients(i), power);
    elseif power == 1
        fprintf(' + %.4f*x', coefficients(i));
    else
        fprintf(' + %.4f', coefficients(i));
    end
end
fprintf('\n');

% compute and display the error
approx_points = phi(x_points);
error = sqrt(sum((f_points - approx_points).^2));
fprintf('root mean square error: %.6f\n', error);
