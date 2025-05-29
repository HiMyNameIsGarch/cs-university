% DO NOT RUN, THIS HAS A BUG IN IT, INFINITE LOOP

x0 = 0.5;
eps = 1e-10;

% first iter func: x = e^-x
[x1, n1] = fixed_iter(x0, eps, @g1);

% second iter func: x = (1+x)/e^x
[x2, n2] = fixed_iter(x0, eps, @g2);

% third iter func: x = x + 1 - x*e^x
[x3, n3] = fixed_iter(x0, eps, @g3);

% show res
disp('first iter func:')
disp(['approx: ', num2str(x1)])
disp(['steps: ', num2str(n1)])

disp('second iter func:')
disp(['approx: ', num2str(x2)])
disp(['steps: ', num2str(n2)])

disp('third iter func:')
disp(['approx: ', num2str(x3)])
disp(['steps: ', num2str(n3)])

% func: fixed pt iter
function [x, n] = fixed_iter(x0, eps, g)
    x = x0;
    n = 0;
    while true
        x_new = g(x);
        n = n + 1;
        if abs(x_new - x) < eps
            break
        end
        x = x_new;
    end
end

% g1(x) = e^-x
function y = g1(x)
    y = exp(-x);
end

% g2(x) = (1+x)/e^x
function y = g2(x)
    y = (1 + x)/exp(x);
end

% g3(x) = x + 1 - x*e^x
function y = g3(x)
    y = x + 1 - x * exp(x);
end

