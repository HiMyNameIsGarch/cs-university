% figure for point selection
figure;
axis([0 3 0 5]);
title('click 10 points in the [0,3]×[0,5] plane');
xlabel('x-axis');
ylabel('y-axis');
grid on;
hold on;

% get 10 points from usor
[x, y] = ginput(10);
points = [x, y];

plot(x,y, 'ro');

poly = polyfit(x,y,2);

x_fine_line = linspace(0, 3, 100);
y_fine_line = polyval(poly, x_fine_line);

plot(x_fine_line, y_fine_line, 'b-');

legend("Chosen points", "Fitted line");
hold off;

