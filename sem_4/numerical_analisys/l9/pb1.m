%---------------------------------< part a >-----------------------------------
% Single rectangle (midpoint) formula
a = 1;
b = 1.5;
integral_1a = rectangle_midpoint(@f1, a, b);
fprintf('a: Single rectangle approximation = %.4f\n', integral_1a);

%---------------------------------< part b >-----------------------------------
% plot the function and rectangle
plot_function_and_rectangle(@f1, a, b);

%---------------------------------< part c >-----------------------------------
% repeated rectangle formula
n_values = [150, 500];
for i = 1:length(n_values)
    n = n_values(i);
    integral_1c = repeated_rectangle(@f1, a, b, n);
    fprintf('c: Repeated rectangle (n=%d) approximation = %.4f\n', n, integral_1c);
end

% Function definitions at the end as requested
function y = f1(x)
    y = exp(-x.^2);
end

function integral = rectangle_midpoint(f, a, b)
    % midpoint rectangle formula for single interval
    midpoint = (a + b)/2;
    integral = (b - a) * f(midpoint);
end

function integral = repeated_rectangle(f, a, b, n)
    % repeated rectangle formula (midpoint) for n intervals
    h = (b - a)/n;
    x = a + h/2:h:b - h/2; % midpoints of each subinterval
    integral = h * sum(f(x));
end

function plot_function_and_rectangle(f, a, b)
    % plot the function and the approximating rectangle
    figure;
    hold on;

    % plot the function
    x_fine = linspace(a, b, 1000);
    plot(x_fine, f(x_fine), 'b-', 'LineWidth', 2);

    % calculate rectangle parameters
    midpoint = (a + b)/2;
    height = f(midpoint);
    width = b - a;

    % plot the rectangle
    rectangle('Position', [a, 0, width, height], 'EdgeColor', 'r', 'LineWidth', 1.5);

    % plot the midpoint
    plot(midpoint, height, 'ro', 'MarkerFaceColor', 'r');

    % labels and title
    xlabel('x');
    ylabel('f(x)');
    title('Function e^{-x^2} and Midpoint Rectangle Approximation');
    legend('f(x) = e^{-x^2}', 'Approximating rectangle', 'Midpoint');
    grid on;
    hold off;
end
