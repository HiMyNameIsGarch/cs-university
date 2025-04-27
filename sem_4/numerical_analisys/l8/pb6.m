f = @(t) (2/sqrt(pi)) * exp(-t.^2);

% parameters
a = 0;
b = 0.5;  % erf(0.5)
exact = 0.520499876;

% compute for n=4 and n=10
n1 = 4;
n2 = 10;

erf4 = comp_simpson(f, a, b, n1);
erf10 = comp_simpson(f, a, b, n2);

% display results
fprintf('Approximation with n=%d: %.9f\n', n1, erf4);
fprintf('Approximation with n=%d: %.9f\n', n2, erf10);
fprintf('Exact value: %.9f\n', exact);

% error analysis
err4 = abs(erf4 - exact);
err10 = abs(erf10 - exact);

fprintf('\nError analysis:\n');
fprintf('n=%d error: %.2e\n', n1, err4);
fprintf('n=%d error: %.2e\n', n2, err10);

% relative error
rel_err4 = err4/exact;
rel_err10 = err10/exact;

fprintf('\nRelative error:\n');
fprintf('n=%d relative error: %.2e\n', n1, rel_err4);
fprintf('n=%d relative error: %.2e\n', n2, rel_err10);

% plot convergence
n_values = [4, 10, 20, 50, 100];
errors = zeros(size(n_values));

for i = 1:length(n_values)
    approx = comp_simpson(f, a, b, n_values(i));
    errors(i) = abs(approx - exact);
end

figure;
loglog(n_values, errors, 'o-', 'LineWidth', 2);
xlabel('Number of subintervals (n)');
ylabel('Absolute error');
title('Convergence of Simpson''s Rule for erf(0.5)');
grid on;

% composite Simpson's rule function
function I = comp_simpson(f, a, b, n)
    h = (b - a)/n;
    x = a:h:b;
    y = f(x);
    I = h/3 * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));
end

