% Use Nevilleís algorithm to approximate sq(3) for:
% point a : the function f1(x) = 3^x and the nodes
% x0 = -2;
% x1 = -1;
% x2 = 0;
% x3 = 1;
% x4 = 2.

% point b : the function f2(x) = sq(x) and the nodes
% x0 = 0;
% x1 = 1;
% x2 = 2;
% x3 = 4;
% x4 = 5.

%----------------------------------< Point a >-------------------------------
x1 = [-2, -1, 0, 1, 2];
y1 = 3 .^ x1; % Evaluate f1 at the nodes

% point to evaluate
x_eval1 = 1/2;
approx1 = neville_algo(x1, y1, x_eval1);

fprintf('Approximation of sqrt(3) using f1(x) = 3^x: %.6f\n', approx1);

%----------------------------------< Point b >----------------------------------
x2 = [0, 1, 2, 4, 5];
y2 = sqrt(x2);

% point to evaluate
x_eval2 = 3;
approx2 = neville_algo(x2, y2, x_eval2);

fprintf('Approximation of sqrt(3) using f2(x) = sqrt(x): %.6f\n', approx2);
