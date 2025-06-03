% Initial guess
x = [1; -1];

% Tolerance
epsilon = 1e-6;

% Maximum number of iterations to prevent infinite loop
max_iter = 100;

for k = 1:max_iter
    % Evaluate functions
    f = system_equations(x);

    % Evaluate Jacobian
    J = jacobian_matrix(x);

    % Newton step
    dx = -J \ f;

    % Update solution
    x_new = x + dx;

    % Check convergence
    if norm(dx, inf) < epsilon
        fprintf('Converged in %d iterations.\n', k);
        fprintf('Solution: x1 = %.8f, x2 = %.8f\n', x_new(1), x_new(2));
        return;
    end

    x = x_new;
end

error('Did not converge within the maximum number of iterations.');


% Define the system of equations as a vector function
function f = system_equations(x)
    x1 = x(1);
    x2 = x(2);
    f = [x1^3 + 2*x2^2 - 21;
         x1^2 + 2*x2 + 2];
end

% Define the Jacobian matrix of the system
function J = jacobian_matrix(x)
    x1 = x(1);
    x2 = x(2);
    J = [3*x1^2,     4*x2;
         2*x1,       2];
end


