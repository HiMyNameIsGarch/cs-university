% Consider the function f:[-1, 1]-> R and n = 10 nodes in the inteval [-1, 1]:

% interval
a = -1;
b = 1;

% nodes
n = 10;

x_interval = linspace(a, b, 1000);
x_equidistant = linspace(a, b, n);

x_chebyshev1 = cos(2 * (1:n) - 1) * pi/(2 * n);
x_chebyshev2 = cos( (1:n-1) * pi / n);

%----------------------------------< Point a >---------------------------------
% Compute the Lebesque function g(x) = sum over i=1 to n of |li(x)|, at a given
% point x, where li(x), i=1..n are the fundamental Lagrange polynomials.

% Compute Lebesgue functions
g_equidistant = arrayfun(@(x) lebesgue_function(x, x_equidistant), x_interval);
g_chebyshev1 = arrayfun(@(x) lebesgue_function(x, x_chebyshev1), x_interval);
g_chebyshev2 = arrayfun(@(x) lebesgue_function(x, x_chebyshev2), x_interval);


% plotting
figure;

%----------------------------------< Point b >---------------------------------
% Plot the function g for n equidistant nodes in [-1, 1]:
subplot(3, 1, 1);
plot(x_interval, g_equidistant);

% information
title('lebesgue func for equidistant nodes');
xlabel('x');
ylabel('g(x)');

%----------------------------------< Point c >---------------------------------
% Plot the function g for n Chebyshev nodes of the first kind,
%x_i = cos( (2i-1)*pi/(2n) ) in [-1,1] where i=1..n:

subplot(3, 1, 2);
plot(x_interval, g_chebyshev1);

% information
title('lebesgue func for chebyshev nodes, first kind');
xlabel('x');
ylabel('g(x)');

%----------------------------------< Point d >---------------------------------
% Plot the function g for n Chebyshev nodes of the second kind,
% xi = cos( i*pi/n ) in [-1,1] where i=1..n-1:

subplot(3, 1, 3);
plot(x_interval, g_chebyshev2);

% information
title('lebesgue func for chebyshev nodes, second kind');
xlabel('x');
ylabel('g(x)');


%---------------------------< lebesque function >------------------------------
function g = lebesgue_function(x, nodes)
    n = length(nodes);
    g = zeros(size(x));
    for i = 1:n
        l_i = ones(size(x));
        for j = 1:n
            if j ~= i
                % formula
                nominator = x - nodes(j);
                denominator = nodes(i) - nodes(j);
                % update the term in the sum
                l_i = l_i .* (nominator / denominator);
            end
        end
        % update the sum with the current term
        g = g + abs(l_i);
    end
end
