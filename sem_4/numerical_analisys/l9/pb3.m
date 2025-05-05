% define the function and integration limits
a = 1;
b = 3;
epsilon = 1e-4;
exact_value = -1.4260247818;

% plot the function
plot_function(@f3, a, b);

% corrected adaptive Simpson's quadrature
[adaptive_result, adaptive_points] = corrected_adaptive_simpson(@f3, a, b, epsilon);
fprintf('\nCorrected Adaptive Simpson result = %.10f\n', adaptive_result);
fprintf('Number of function evaluations: %d\n', adaptive_points);
fprintf('Error: %.2e\n', abs(adaptive_result - exact_value));

% repeated Simpson's formula
n_values = [50, 100];
for n = n_values
    repeated_result = repeated_simpson(@f3, a, b, n);
    fprintf('Repeated Simpson (n=%d) result = %.10f\n', n, repeated_result);
    fprintf('Error: %.2e\n', abs(repeated_result - exact_value));
end

% function definitions at the end
function y = f3(x)
    y = (100 ./ x.^2) .* sin(10 ./ x);
end

function plot_function(f, a, b)
    figure;
    x = linspace(a, b, 10000);
    plot(x, f(x), 'b-', 'LineWidth', 1.5);
    xlabel('x');
    ylabel('f(x)');
    title('Plot of f(x) = (100/x^2)sin(10/x)');
    grid on;
end

function [integral, count] = corrected_adaptive_simpson(f, a, b, tol)
    % corrected adaptive Simpson implementation
    count = 0;
    [integral, count] = simpson_adaptive(f, a, b, tol, count);
end

function [S, count] = simpson_adaptive(f, a, b, tol, count)
    % recursive adaptive Simpson's rule
    c = (a + b)/2;
    h = b - a;

    % evaluate function at five points
    fa = f(a); fb = f(b); fc = f(c);
    fd = f((a+c)/2); fe = f((c+b)/2);
    count = count + 5;

    % Simpson's rule approximations
    S1 = h/6 * (fa + 4*fc + fb);
    S2 = h/12 * (fa + 4*fd + 2*fc + 4*fe + fb);

    % error estimate
    err = abs(S2 - S1)/15;

    if err <= tol
        S = S2 + (S2 - S1)/15; % Richardson extrapolation
    else
        [Sleft, count] = simpson_adaptive(f, a, c, tol/2, count);
        [Sright, count] = simpson_adaptive(f, c, b, tol/2, count);
        S = Sleft + Sright;
    end
end

function integral = repeated_simpson(f, a, b, n)
    % repeated Simpson's rule for n subintervals
    if mod(n,2) ~= 0
        error('n must be even for Simpson''s rule');
    end

    h = (b - a)/n;
    x = a:h:b;
    y = f(x);

    % weights pattern: 1 4 2 4 2 ... 4 1
    weights = 2*ones(1,n+1);
    weights(2:2:n) = 4;
    weights(1) = 1;
    weights(n+1) = 1;

    integral = h/3 * sum(weights .* y);
end
