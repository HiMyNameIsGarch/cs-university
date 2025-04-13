% data
% temperature
T = [0, 10, 20, 30, 40, 60, 80, 100];
% pressure
P = [0.0061, 0.0123, 0.0234, 0.0424, 0.0738, 0.1992, 0.4736, 1.0133];

% exact value at T = 45
P_exact_45 = 0.095848;

%----------------------------------< Part a >-----------------------------------
degree1 = 2; % Quadratic polynomial
degree2 = 3; % Cubic polynomial

% Fit polynomials
p1 = polyfit(T, P, degree1);
p2 = polyfit(T, P, degree2);

% Evaluate at T = 45
P1_45 = polyval(p1, 45);
P2_45 = polyval(p2, 45);

% Calculate approximation errors
error1 = abs(P1_45 - P_exact_45);
error2 = abs(P2_45 - P_exact_45);

% Display results
fprintf('Quadratic (degree 2) approximation:\n');
fprintf('  P(45) = %.6f, Error = %.6f\n', P1_45, error1);
fprintf('Coefficients: '); disp(p1);

fprintf('\nCubic (degree 3) approximation:\n');
fprintf('  P(45) = %.6f, Error = %.6f\n', P2_45, error2);
fprintf('Coefficients: '); disp(p2);

%----------------------------------< Part b >-----------------------------------
% smooth plots
T_plot = linspace(0, 100, 500);

% compute poly values
P1_plot = polyval(p1, T_plot);
P2_plot = polyval(p2, T_plot);

% interpolation poly (degree = number of points - 1)
p_interp = polyfit(T, P, length(T) - 1);
P_interp_plot = polyval(p_interp, T_plot);

% plot time
figure;
hold on;

% data points
plot(T, P, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'data points');

% approximating polynomials
plot(T_plot, P1_plot, 'b-', 'LineWidth', 2, 'DisplayName', sprintf('quadratic (degree %d)', degree1));
plot(T_plot, P2_plot, 'r--', 'LineWidth', 2, 'DisplayName', sprintf('cubic (degree %d)', degree2));

% interpolation polynomial
plot(T_plot, P_interp_plot, 'g:', 'LineWidth', 2, 'DisplayName', 'interpolation poly');

% point at T = 45
plot(45, P_exact_45, 'ms', 'MarkerFaceColor', 'm', 'MarkerSize', 10, 'DisplayName', 'exact P(45)');

% information
xlabel('temperature (C)');
ylabel('vapor pressure (bars)');
title('vapor pressure of water: approximations and interpolation');
legend('location', 'northwest');
grid on;
hold off;

% better visualization
axis([0 100 0 1.1]);
