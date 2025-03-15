% the function
f = @(x) 1 ./ (1 + x.^2);

% interval
x_interval = linspace(-5, 5, 1000); % dense points

% degrees of the polynomial
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

figure; % start the figure
for idx = 1:length(n_values)
    n = n_values(idx);
    % eq spaced nodes
    x_nodes = linspace(-5, 5, n + 1);
    y_nodes = f(x_nodes);

    % lagrange interp poly
    y_interp = zeros(size(x_interval)); % fill with zeroes
    for k = 1:length(x_interval) % for each value in the x interval compute the interpolation at that point
        y_interp(k) = lagrange_interpolation(x_nodes, y_nodes, x_interval(k));
    end

    % Compute maximum interpolation error
    error = max(abs(f(x_interval) - y_interp));
    fprintf('n = %d, max error: %.6f\n', n, error);

    % Plot the function and interpolation polynomial
    subplot(rows,cols,idx);
    plot(x_interval, f(x_interval), 'b-', 'LineWidth', 2); % Original function
    hold on;
    plot(x_interval, y_interp, 'r--', 'LineWidth', 2); % lagrange interpolation with RED
    plot(x_nodes, y_nodes, 'ko', 'MarkerFaceColor', 'k'); % Interpolation nodes with BLUE
    title(sprintf('n = %d', n));
    grid on;
    hold off;
end

% lagrange interpolation function the same function all over again
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
