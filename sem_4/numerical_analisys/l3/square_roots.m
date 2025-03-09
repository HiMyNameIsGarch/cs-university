% Given data points
x_nodes = [216, 225, 256]; % Known x values
y_nodes = sqrt(x_nodes);   % Known sqrt(x) values

% Point to interpolate
x_interp = 219;

% Lagrange interpolation
y_interp = lagrange_interpolation(x_nodes, y_nodes, x_interp);

% Display the result
fprintf('Approximate sqrt(219) using Lagrange interpolation: %.6f\n', y_interp);

% Lagrange interpolation function
function y_interp = lagrange_interpolation(x, y, x_interp)
    n = length(x);
    y_interp = 0;
    for i = 1:n
        L = 1;
        for j = 1:n
            if j ~= i
                L = L * (x_interp - x(j)) / (x(i) - x(j));
            end
        end
        y_interp = y_interp + y(i) * L;
    end
end
