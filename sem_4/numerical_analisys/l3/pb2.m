x_nodes = [216, 225, 256];
y_nodes = sqrt(x_nodes);

x_interp = 219;

y_interp = lagrange_interpolation(x_nodes, y_nodes, x_interp);

fprintf('sqrt(219): %.6f\n', y_interp);
