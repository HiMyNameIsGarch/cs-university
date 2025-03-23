% Using the data from the following table

% x    1 1.5     2       3       4
% lg x 0 0,17609 0,30103 0,47712 0,60206

% approximate lg 2,5 and lg 3,25 using the Newton interpolation polynomial. Es-
% timate the maximum interpolation error E = max|f(y_i) - (N_4f)(y_i)|;
% with y_i = i/10 for i = 10,35:

% data points
x = [1, 1.5, 2, 3, 4];
lg_x = [0, 0.17609, 0.30103, 0.47712, 0.60206];

% points to approximate
x_approx = [2.5, 3.25];

% using y_i defined as
i = 10:0.01:35;
y_i = i / 10;

% initialization for the divided differences table
F_at_x = compute_divided_differences(x, lg_x);

% evaluate the polynomial at the points
lg_approx = newton_poly(x, F_at_x, x_approx);

% print the results
fprintf('approx of lg 2.5: %.5f\n', lg_approx(1));
fprintf('approx of lg 3.25: %.5f\n', lg_approx(2));

% interpolated values
N_y_i = newton_poly(x, F_at_x, y_i);

% maximum interpolation error
Err = max(abs(log10(y_i) - N_y_i));

% print the error
fprintf('max interpolation error: %.5f\n', Err);
