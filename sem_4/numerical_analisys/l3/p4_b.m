f = @(x) 1 ./ (1 + x.^2);

x_interval = linspace(-5, 5, 1000); % dense points

% same degrees as in point a
n_values = [2, 4, 6, 8];

% compute line and column from the n_values vector
len = length(n_values);
try % try to compute the number of rows and columns
    rows = ceil(sqrt(len));
    cols = ceil(len / rows);
catch % if the above fails
    rows = 2;
    cols = 2;
end

figure;

for idx = 1:length(n_values)
    n = n_values(idx);
    % chebyshev nodes
    x_nodes1 = 5 * cos(((0:n)*pi)/20);
    y_nodes1 = f(x_nodes1);

    x_nodes2 = 5 * cos((2 * (0:n) + 1) * pi / 42); % new function yay
    y_nodes2 = f(x_nodes2);

    % lagrange interp poly
    y_interp1 = zeros(size(x_interval)); % fill zeroes
    y_interp2 = zeros(size(x_interval)); % fill zeroes
    for k = 1:length(x_interval)
        y_interp1(k) = lagrange_interpolation(x_nodes1, y_nodes1, x_interval(k));
        y_interp2(k) = lagrange_interpolation(x_nodes2, y_nodes2, x_interval(k));
    end

    % maximum interpolation error
    error = max(abs(f(x_interval) - y_interp));
    fprintf('n = %d, max error: %.6f\n', n, error);

    % Plot the function and interpolation polynomial
    subplot(rows,cols,idx);
    plot(x_interval, f(x_interval), 'b-', 'LineWidth', 2); % original
    hold on;
    plot(x_interval, y_interp, 'r--', 'LineWidth', 2); % lagrange
    plot(x_nodes1, y_nodes1, 'ko', 'MarkerFaceColor', 'k'); % nodes
    title(sprintf('n = %d', n));
    grid on;
    hold off;
end

% nu mai explic iar formula asta
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
