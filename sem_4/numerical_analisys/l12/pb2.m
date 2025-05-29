% Define system
A = [3, 1, 1;
    -2, 4, 0;
    -1, 2, -6];
b = [12; 2; -5];

% Tolerance and settings
epsilon = 1e-5;
max_iter = 1000;
n = length(b);

% Decompose A into D, L, U
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);

%% Jacobi Method: x^(k+1) = D^(-1) * (b - (L + U)x^(k))
x_jacobi = zeros(n,1);
iter_jacobi = 0;
T_jacobi = -inv(D) * (L + U);
c_jacobi = inv(D) * b;

while iter_jacobi < max_iter
    x_new = T_jacobi * x_jacobi + c_jacobi;
    iter_jacobi = iter_jacobi + 1;
    if norm(x_new - x_jacobi, inf) < epsilon
        break;
    end
    x_jacobi = x_new;
end

%% Gauss-Seidel Method: x^(k+1) = (D + L)^(-1) * (b - U * x^(k))
x_gs = zeros(n,1);
iter_gs = 0;
T_gs = -(D + L) \ U;
c_gs = (D + L) \ b;

while iter_gs < max_iter
    x_new = T_gs * x_gs + c_gs;
    iter_gs = iter_gs + 1;
    if norm(x_new - x_gs, inf) < epsilon
        break;
    end
    x_gs = x_new;
end

%% SOR Method: x^(k+1) = (D + wL)^(-1) * (w*b - [(wU + (w-1)D)] * x^(k))
omega = 1.1;  % relaxation factor
x_sor = zeros(n,1);
iter_sor = 0;
T_sor = inv(D + omega * L) * ((1 - omega) * D - omega * U);
c_sor = omega * inv(D + omega * L) * b;

while iter_sor < max_iter
    x_new = T_sor * x_sor + c_sor;
    iter_sor = iter_sor + 1;
    if norm(x_new - x_sor, inf) < epsilon
        break;
    end
    x_sor = x_new;
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
