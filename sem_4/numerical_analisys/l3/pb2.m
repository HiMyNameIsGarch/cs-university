x_nodes = [216, 225, 256];
y_nodes = sqrt(x_nodes);

x_interp = 219;

y_interp = lagrange_interpolation(x_nodes, y_nodes, x_interp);

fprintf('sqrt(219): %.6f\n', y_interp);

function y_interp = lagrange_interpolation(x, y, x_interp)
    n = length(x);
    y_interp = 0;
    for i = 1:n
        L = 1;
        for j = 1:n
            if j ~= i % trivial formula from the course
                L = L * (x_interp - x(j)) / (x(i) - x(j));
            end
        end
        y_interp = y_interp + y(i) * L;
    end
end
