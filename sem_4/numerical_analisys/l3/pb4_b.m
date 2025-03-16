f = @(x) 1 ./ (1 + x.^2);

% interval boundaries
a = -5;
b = 5;

n_values = [2, 4, 6, 8];

y_i = (0:0.01:100)/10 - 5;

len = length(n_values);

% Compute line and column from the n_values vector
[rows, cols] = rowscols(len);

i = 0:20;

figure;

for k = 1:len
    n = n_values(k);

    % x_i
    % x_nodes_v1 = 5 * cos(i * pi / 20);
    x_nodes_v1 = 5 * cos((0:n) * pi / n);
    y_nodes_v1 = f(x_nodes_v1);

    % x_i2
    % x_nodes_v2 = 5 * cos((2 * i + 1) * pi / 42);
    x_nodes_v2 = 5 * cos((2*(0:n) + 1) * pi / (2*(n + 1)));
    y_nodes_v2 = f(x_nodes_v2);

    % fill with zeros
    y_interp_v1 = zeros(size(y_i));
    y_interp_v2 = zeros(size(y_i));
    for m = 1:length(y_i)
        y_interp_v1(m) = lagrange_interpolation(x_nodes_v1, y_nodes_v1, y_i(m));
        y_interp_v2(m) = lagrange_interpolation(x_nodes_v2, y_nodes_v2, y_i(m));
    end

    % Compute the maximum interpolation error for both versions
    E_n_v1 = max(abs(f(y_i) - y_interp_v1));
    E_n_v2 = max(abs(f(y_i) - y_interp_v2));
    fprintf('n = %d, max err v1: %.6f, max err v2: %.6f\n', n, E_n_v1, E_n_v2);

    % subplotting
    subplot(rows, cols, k);

    % original function
    plot(y_i, f(y_i), 'b-', 'LineWidth', 2);
    hold on;

    % langrange with x_i ( red )
    plot(y_i, y_interp_v1, 'r--', 'LineWidth', 2);

    % lagrnage with x_i2 ( green )
    plot(y_i, y_interp_v2, 'g--', 'LineWidth', 2);

    % interpolation ( black )
    plot(x_nodes_v1, y_nodes_v1, 'ko', 'MarkerFaceColor', 'k');

    % interpolation ( magenta )
    plot(x_nodes_v2, y_nodes_v2, 'mo', 'MarkerFaceColor', 'm');

    % usefull informations
    title(fprintf('n = %d, max err v1: %.6f, max err v2: %.6f\n', n, E_n_v1, E_n_v2));
    legend('f(x)', 'P_n(x) v1', 'P_n(x) v2', 'Nodes v1', 'Nodes v2');

    grid on;
    hold off;
end
