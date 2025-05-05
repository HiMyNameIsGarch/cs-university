f = @(x,y) log(x + 2*y);
a = 1.4; b = 2; c = 1; d = 1.5;

% high-resolution (100x100 grid)
nx = 100; ny = 100;
hx = (b - a)/nx;
hy = (d - c)/ny;
x = a:hx:b;
y = c:hy:d;

sum_f = 0;

for i = 1:length(x)
    for j = 1:length(y)
        if (i==1||i==length(x)) && (j==1||j==length(y))
            weight = 1;
        elseif (i==1||i==length(x)) || (j==1||j==length(y))
            weight = 2;
        else
            weight = 4;
        end
        sum_f = sum_f + weight * f(x(i), y(j));
    end
end

I = hx * hy / 4 * sum_f;

fprintf('final approximation: %.7f\n', I);
