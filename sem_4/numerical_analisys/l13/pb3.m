format long

E = 1;  % init val
n_steps = 6;

% newton iter
for i = 1:n_steps
    fE = f(E);
    dfE = df(E);
    E = E - fE / dfE;
end

% show res
disp('kepler eq (newton, 6 steps):')
disp(['approx: ', num2str(E)])

% f(E) = E - 0.8*sin(E) - 2pi/10
function y = f(E)
    y = E - 0.8 * sin(E) - (2 * pi / 10);
end

% f'(E) = 1 - 0.8*cos(E)
function y = df(E)
    y = 1 - 0.8 * cos(E);
end
