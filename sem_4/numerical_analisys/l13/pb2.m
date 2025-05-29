x0 = pi/4;  % init val
eps = 1e-4;  % tol
nmax = 100;  % max steps

[x, n] = newton(x0, eps, nmax);

% show res
disp('newton res:')
disp(['approx: ', num2str(x)])
disp(['steps: ', num2str(n)])

% func: newton meth
function [x, n] = newton(x0, eps, nmax)
    x = x0;
    n = 0;
    while n < nmax
        fx = f(x);
        dfx = df(x);
        if dfx == 0
            error('div by 0')
        end
        x_new = x - fx/dfx;
        n = n + 1;
        if abs(x_new - x) < eps
            x = x_new;
            return
        end
        x = x_new;
    end
end

% f(x) = x - cos(x)
function y = f(x)
    y = x - cos(x);
end

% f'(x) = 1 + sin(x)
function y = df(x)
    y = 1 + sin(x);
end
