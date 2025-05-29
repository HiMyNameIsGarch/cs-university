x_real = 0.61546850;  % known sol
eps = 0.5e-6;  % for 6 sig digs

% bisection
[xb, nb, eb] = bisect(0.5, 1, eps);

% secant
[xs, ns, es] = secant(0.5, 1, eps);

% newton
[xn, nn, en] = newton(0.5, eps);

% show res
disp('bisection:')
disp(['steps: ', num2str(nb)])
disp(['final err: ', num2str(eb(end))])

disp('secant:')
disp(['steps: ', num2str(ns)])
disp(['final err: ', num2str(es(end))])

disp('newton:')
disp(['steps: ', num2str(nn)])
disp(['final err: ', num2str(en(end))])

% f(x)
function y = f(x)
    y = x - 0.2 * sin(x) - 0.5;
end

% df(x)
function y = df(x)
    y = 1 - 0.2 * cos(x);
end

% bisection
function [c, n, err] = bisect(a, b, eps)
    err = [];
    for n = 1:100
        c = (a + b)/2;
        fc = f(c);
        err(end+1) = abs(c - 0.61546850);
        if abs(fc) < eps
            return
        end
        if f(a)*fc < 0
            b = c;
        else
            a = c;
        end
    end
end

% secant
function [x, n, err] = secant(x0, x1, eps)
    err = [];
    for n = 1:100
        f0 = f(x0);
        f1 = f(x1);
        if f1 - f0 == 0
            break
        end
        x = x1 - f1 * (x1 - x0)/(f1 - f0);
        err(end+1) = abs(x - 0.61546850);
        if abs(x - x1) < eps
            return
        end
        x0 = x1;
        x1 = x;
    end
end

% newton
function [x, n, err] = newton(x0, eps)
    err = [];
    for n = 1:100
        fx = f(x0);
        dfx = df(x0);
        if dfx == 0
            break
        end
        x = x0 - fx / dfx;
        err(end+1) = abs(x - 0.61546850);
        if abs(x - x0) < eps
            return
        end
        x0 = x;
    end
end
