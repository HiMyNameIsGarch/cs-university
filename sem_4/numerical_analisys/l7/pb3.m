% figure for point selection
figure;
axis([0 3 0 5]);
title('click 10 points in the [0,3]×[0,5] plane');
xlabel('x-axis');
ylabel('y-axis');
grid on;

% get 10 points from usor
[x, y] = ginput(10);
points = [x, y];

% design matrix for 2nd degree poly fit
% the model is: z = a*x^2 + b*y^2 + c*x*y + d*x + e*y + f
X = [x.^2, y.^2, x.*y, x, y, ones(size(x))];

% solve the least squares problem
coefficients = X \ zeros(size(x));

% create grid for surface plot
[x_grid, y_grid] = meshgrid(linspace(0, 3, 50), linspace(0, 5, 50));

% evaluate the polynomial on the grid
z_fit = coefficients(1)*x_grid.^2 + coefficients(2)*y_grid.^2 + ...
         coefficients(3)*x_grid.*y_grid + coefficients(4)*x_grid + ...
         coefficients(5)*y_grid + coefficients(6);

% plot
figure;
hold on;

% random points
scatter3(x, y, zeros(size(x)), 50, 'filled', 'MarkerFaceColor', 'b');
text(x, y, zeros(size(x)), num2str((1:10)'), 'VerticalAlignment', 'bottom');

% fitted surface
surf(x_grid, y_grid, z_fit, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
colormap('parula');

% Add labels and title
xlabel('x-axis [0,3]');
ylabel('y-axis [0,5]');
zlabel('z-value');
title('2nd degree least squares polynomial fit to random points');
legend('random Points', 'fitted polynomial Surface', 'location', 'best');
grid on;
hold off;

% polynomial equation
fprintf('the fitted 2nd degree polynomial equation is:\n');
fprintf('z = %.4f*x^2 + %.4f*y^2 + %.4f*x*y + %.4f*x + %.4f*y + %.4f\n', coefficients);
