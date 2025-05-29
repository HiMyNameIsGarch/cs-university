% System definition
A = [3,-1,0,0,0,0;
    -1,3,-1,0,0,0;
     0,-1,3,-1,0,0;
     0,0,-1,3,-1,0;
     0,0,0,-1,3,-1;
     0,0,0,0,-1,3];

b = [2;1;1;1;1;2];

% Common settings
epsilon = 1e-3;        % convergence tolerance
max_iter = 1000;       % max iterations
n = length(b);         % size of system

%% Jacobi Method
x_jacobi = zeros(n,1);            % initial guess
x_new = x_jacobi;
iter_jacobi = 0;
while iter_jacobi < max_iter
    for i = 1:n
        sigma = 0;
        for j = 1:n
            if j ~= i
                sigma = sigma + A(i,j) * x_jacobi(j);
            end
        end
        x_new(i) = (b(i) - sigma) / A(i,i);
    end
    iter_jacobi = iter_jacobi + 1;
    if norm(x_new - x_jacobi, inf) < epsilon
        break;
    end
    x_jacobi = x_new;
end

%% Gauss-Seidel Method
x_gs = zeros(n,1);      % initial guess
iter_gs = 0;
while iter_gs < max_iter
    x_old = x_gs;
    for i = 1:n
        sigma = 0;
        for j = 1:n
            if j ~= i
                sigma = sigma + A(i,j) * x_gs(j);
            end
        end
        x_gs(i) = (b(i) - sigma) / A(i,i);
    end
    iter_gs = iter_gs + 1;
    if norm(x_gs - x_old, inf) < epsilon
        break;
    end
end

%% SOR Method
omega = 1.25;            % relaxation factor
x_sor = zeros(n,1);      % initial guess
iter_sor = 0;
while iter_sor < max_iter
    x_old = x_sor;
    for i = 1:n
        sigma = 0;
        for j = 1:n
            if j ~= i
                sigma = sigma + A(i,j) * x_sor(j);
            end
        end
        x_sor(i) = (1 - omega) * x_sor(i) + omega * (b(i) - sigma) / A(i,i);
    end
    iter_sor = iter_sor + 1;
    if norm(x_sor - x_old, inf) < epsilon
        break;
    end
end

%% Display Results
fprintf('--- Jacobi Method ---\n');
fprintf('Iterations: %d\n', iter_jacobi);
disp(x_jacobi);

fprintf('--- Gauss-Seidel Method ---\n');
fprintf('Iterations: %d\n', iter_gs);
disp(x_gs);

fprintf('--- SOR Method (omega = %.2f) ---\n', omega);
fprintf('Iterations: %d\n', iter_sor);
disp(x_sor);
