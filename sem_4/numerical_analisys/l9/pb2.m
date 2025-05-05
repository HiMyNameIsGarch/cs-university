% define the function and integration limits
a = 0;
b = 1;
epsilon = 1e-4;
exact_value = pi; % since integral(2/(1+x^2)) from 0 to 1 is 2*atan(1) = pi/2 * 2 = pi

% part 2a: Romberg algorithm (standard form)
[result_a, n_a] = romberg_standard(@f2, a, b, epsilon);
fprintf('a: Romberg standard result = %.8f (reached in %d iterations)\n', result_a, n_a);
fprintf('         Exact value = %.8f, Error = %.2e\n', exact_value, abs(result_a - exact_value));

% part 2b: Romberg algorithm (Aitken's form)
[result_b, n_b] = romberg_aitken(@f2, a, b, epsilon);
fprintf('b: Romberg Aitken result = %.8f (reached in %d iterations)\n', result_b, n_b);
fprintf('         Exact value = %.8f, Error = %.2e\n', exact_value, abs(result_b - exact_value));

% function definitions at the end
function y = f2(x)
    y = 2./(1 + x.^2);
end

function [integral, n] = romberg_standard(f, a, b, epsilon)
    % standard Romberg integration using trapezoidal rule
    max_iter = 20; % maximum number of iterations
    R = zeros(max_iter, max_iter);
    h = b - a;
    R(1,1) = h/2 * (f(a) + f(b));

    for i = 2:max_iter
        % composite trapezoidal rule
        h = h/2;
        sum_f = 0;
        for k = 1:2^(i-2)
            sum_f = sum_f + f(a + (2*k-1)*h);
        end
        R(i,1) = 0.5 * R(i-1,1) + h * sum_f;

        % Richardson extrapolation
        for j = 2:i
            R(i,j) = R(i,j-1) + (R(i,j-1) - R(i-1,j-1))/(4^(j-1) - 1);
        end

        % check for convergence
        if abs(R(i,i) - R(i-1,i-1)) < epsilon
            integral = R(i,i);
            n = i;
            return;
        end
    end
    integral = R(max_iter,max_iter);
    n = max_iter;
end

function [integral, n] = romberg_aitken(f, a, b, epsilon)
    % Romberg integration using Aitken's acceleration
    max_iter = 20;
    T = zeros(max_iter, 1);
    h = b - a;
    T(1) = h/2 * (f(a) + f(b));

    for i = 2:max_iter
        % composite trapezoidal rule
        h = h/2;
        sum_f = 0;
        for k = 1:2^(i-2)
            sum_f = sum_f + f(a + (2*k-1)*h);
        end
        T(i) = 0.5 * T(i-1) + h * sum_f;

        % Aitken's delta-squared process
        if i >= 3
            % compute accelerated value
            R = T(i) - (T(i) - T(i-1))^2 / (T(i) - 2*T(i-1) + T(i-2));

            % check for convergence
            if i >= 4 && abs(R - T(i)) < epsilon
                integral = R;
                n = i;
                return;
            end
        end
    end
    integral = T(max_iter);
    n = max_iter;
end
