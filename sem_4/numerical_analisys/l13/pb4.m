x0 = 1;  % first val
x1 = 2;  % sec val
eps = 1e-4;
nmax = 100;

[x, n] = secant(x0, x1, eps, nmax);

% show res
disp('secant res:')
disp(['approx: ', num2str(x)])
disp(['steps: ', num2str(n)])

% func: secant meth
function [x, n] = secant(x0, x1, eps, nmax)
    f0 = f(x0);
    f1 = f(x1);
    n = 0;
    while n < nmax
        if f1 - f0 == 0
            error('div by 0')
        end
        x = x1 - f1 * (x1 - x0) / (f1 - f0);
        if abs(x - x1) < eps
            return
        end
        x0 = x1;
        f0 = f1;
        x1 = x;
        f1 = f(x1);
        n = n + 1;
    end
end

% f(x) = x^3 - x^2 - 1
function y = f(x)
    y = x^3 - x^2 - 1;
end
