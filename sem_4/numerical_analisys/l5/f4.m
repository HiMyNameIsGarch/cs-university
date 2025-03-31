% The data from the following table are generated
% using the function f(x)= x lnx:

%  x      f(x)       f'(x)
% 8,3   17,56492   3,116256
% 8,6   18,50515   3,151762

% Use the Hermite interpolation polynomial to approximate f(8,4)
% and find the absolute error.

% Given data
x_nodes = [8.3, 8.6];  % x values
f_values = [17.56492, 18.50515];  % f(x) values
df_values = [3.116256, 3.151762];  % f'(x) values

% Function definition (natural logarithm, not base-10)
f = @(x) x .* log(x);  % Note: The problem says log10 but provides ln values

% Compute divided differences
F = compute_divided_differences(x_nodes, f_values, df_values);

% Evaluate at x = 8.4
x_eval = 8.4;
approx = evaluate_poly(x_eval, F, x_nodes);

% Calculate true value and absolute error
true_value = f(x_eval);
abs_error = abs(true_value - approx);

% Display results
fprintf('Hermite approximation at x = 8.4: %.8f\n', approx);
fprintf('True value at x = 8.4: %.8f\n', true_value);
fprintf('Absolute error: %.8f\n', abs_error);
