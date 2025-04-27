% Define the function
f = @(x) x.*log(x);

% Exact integral value (given)
exact = 0.636294368858383;

% Parameters
a = 1;
b = 2;
tolerance = 0.000000005; % For three decimal accuracy

% Initialize variables
n = 1;
prev_approx = 0;
current_approx = 0;
error = Inf;

% Find the smallest n that meets the tolerance
while error > tolerance
    n = n + 1;
    h = (b-a)/n;
    x = a:h:b;
    y = f(x);
    current_approx = h*(0.5*y(1) + sum(y(2:end-1)) + 0.5*y(end));
    error = abs(current_approx - exact);
end

fprintf('Smallest n for 3 decimal accuracy: %d\n', n);
fprintf('Approximation with n=%d: %.15f\n', n, current_approx);
fprintf('Exact value: %.15f\n', exact);
fprintf('Absolute error: %.15f\n', error);

% Verification with larger n
n_verify = 2*n;
h_verify = (b-a)/n_verify;
x_verify = a:h_verify:b;
y_verify = f(x_verify);
verify_approx = h_verify*(0.5*y_verify(1) + sum(y_verify(2:end-1)) + 0.5*y_verify(end));

fprintf('\nVerification with n=%d: %.15f\n', n_verify, verify_approx);
