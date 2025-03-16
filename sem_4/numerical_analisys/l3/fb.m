f = @(x) cos(x);

% nodes
x_nodes = [0, pi/4, pi/3];
y_nodes = f(x_nodes);

% point of evaluation
x_eval = pi/6;

% classical formula
L_classical = 0;
for i = 1:length(x_nodes)
    % Compute the fundamental polynomial l_i(x)
    l_i = @(x) prod((x - x_nodes([1:i-1, i+1:end]))) / prod((x_nodes(i) - x_nodes([1:i-1, i+1:end])));
    % Evaluate the polynomial at x_eval and add to the sum
    L_classical = L_classical + l_i(x_eval) * y_nodes(i);
end

% barycentric formula
w = zeros(1, length(x_nodes));
for i = 1:length(x_nodes)
    w(i) = 1 / prod(x_nodes(i) - x_nodes([1:i-1, i+1:end]));
end

% handle the case where x_eval is exactly equal to a node
if any(x_eval == x_nodes)
    L_barycentric = y_nodes(x_eval == x_nodes);
else
    % Compute the barycentric interpolation
    numerator = sum(w .* y_nodes ./ (x_eval - x_nodes));
    denominator = sum(w ./ (x_eval - x_nodes));
    L_barycentric = numerator / denominator;
end

% Display results
fprintf('x = pi/6 classical : %.6f\n', L_classical);
fprintf('x = pi/6 barycentric: %.6f\n', L_barycentric);
