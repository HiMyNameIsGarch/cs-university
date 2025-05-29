x0 = 0.8;
eps = 1e-10;

% std newton
[x_std, n_std] = newton_std(x0, eps);

% mult ver
[x_mult, n_mult] = newton_mult(x0, eps, 3);  % m = 3

% show res
disp('std newton:')
disp(['steps: ', num2str(n_std)])
disp(['approx: ', num2str(x_std)])

disp('mult newton:')
disp(['steps: ', num2str(n_mult)])
disp(['approx: ', num2str(x_mult)])

% f(x)
function y = f(x)
    p = 2;
    y = (x^2 - 1)^p * log(x);
end

% df(x)
function y = df(x)
    p = 2;
    y = 2*p*(x^2 - 1)^(p - 1)*x*log(x) + (x^2 - 1)^p / x;
end

% std newton
function [x, n] = newton_std(x0, eps)
    for n = 1:100
        fx = f(x0);
        dfx = df(x0);
        if dfx == 0
            break
        end
        x = x0 - fx / dfx;
        if abs(x - x0) < eps
            return
        end
        x0 = x;
    end
end

% mult ver
function [x, n] = newton_mult(x0, eps, m)
    for n = 1:100
        fx = f(x0);
        dfx = df(x0);
        if dfx == 0
            break
        end
        x = x0 - m * fx / dfx;
        if abs(x - x0) < eps
            return
        end
        x0 = x;
    end
end
