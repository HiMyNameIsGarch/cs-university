a = 1;
b = 2;
eps = 1e-4;
nmax = 100;

% bisection
[x_bis, n_bis] = bisect(a, b, eps, nmax);

% false pos
[x_fp, n_fp] = false_pos(a, b, eps, nmax);

% show res
disp('bisection res:')
disp(['approx: ', num2str(x_bis)])
disp(['steps: ', num2str(n_bis)])

disp('false pos res:')
disp(['approx: ', num2str(x_fp)])
disp(['steps: ', num2str(n_fp)])

% func: f(x)
function y = f(x)
    y = (x - 2)^2 - log(x);
end

% bisection meth
function [c, n] = bisect(a, b, eps, nmax)
    fa = f(a);
    fb = f(b);
    if fa * fb > 0
        error('no root in [a,b]')
    end
    for n = 1:nmax
        c = (a + b)/2;
        fc = f(c);
        if abs(fc) < eps
            return
        end
        if fa * fc < 0
            b = c;
            fb = fc;
        else
            a = c;
            fa = fc;
        end
    end
end

% false pos meth
function [c, n] = false_pos(a, b, eps, nmax)
    fa = f(a);
    fb = f(b);
    if fa * fb > 0
        error('no root in [a,b]')
    end
    for n = 1:nmax
        c = (a * fb - b * fa)/(fb - fa);
        fc = f(c);
        if abs(fc) < eps
            return
        end
        if fa * fc < 0
            b = c;
            fb = fc;
        else
            a = c;
            fa = fc;
        end
    end
end
