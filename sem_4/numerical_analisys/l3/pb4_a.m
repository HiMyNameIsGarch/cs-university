f = @(x) 1 ./ (1 + x.^2);

% interval boundaries
a = -5;
b = 5;

n_values = [2, 4, 6, 8];

y_i = (0:0.01:100)/10 - 5;

len = length(n_values);

for k = 1:len
    n = n_values(k);

    % x and y nodes
    x_nodes = (0:n)*(10/n) - 5;
    y_nodes = f(x_nodes);

    % fill with zeros
    y_interp = zeros(size(y_i));

    % at each point compute the interpolation
    for m = 1:length(y_i)
        y_interp(m) = lagrange_interpolation(x_nodes, y_nodes, y_i(m));
    end

    % max interpolation error
    E_n = max(abs(f(y_i) - y_interp));
    fprintf('n = %d, max error: %.6f\n', n, E_n);
end
