%-----------------------------------< Part a >-----------------------------------
n_values_a = [10, 15]; % sizes to compute
cond_numbers_a = zeros(length(n_values_a), 1); % store condition numbers

for i = 1:length(n_values_a)
    n = n_values_a(i);
    t = 1./(1:n)'; % points t_k = 1/k
    V = fliplr(vander(t)); % built-in vandermonde matrix (columns are t.^(n-1:-1:0))
    cond_numbers_a(i) = cond(V, 2); % 2-norm condition number
    fprintf('n = %d (t_k=1/k), condition number = %e\n', n, cond_numbers_a(i));
end

%-----------------------------------< Part b >-----------------------------------
% Vandermonde matrices for tk = -1 + (2/n)*k, k=1..n
n_values_b = 10:15; % sizes to compute
cond_numbers_b = zeros(length(n_values_b), 1); % store condition numbers

for i = 1:length(n_values_b)
    n = n_values_b(i);
    t = -1 + (2/n)*(1:n)'; % points t_k = -1 + (2/n)*k, uniformly spaced in [-1,1]
    V = fliplr(vander(t)); % built-in vandermonde matrix
    cond_numbers_b(i) = cond(V, 2); % 2-norm condition number
    fprintf('n = %d (uniform [-1,1]), condition number = %e\n', n, cond_numbers_b(i));
end

%% display summary table
fprintf('\nsummary table for uniform points in [-1,1]:\n');
fprintf('n\tcondition number\n');
fprintf('-----------------------\n');
for i = 1:length(n_values_b)
    fprintf('%d\t%e\n', n_values_b(i), cond_numbers_b(i));
end
