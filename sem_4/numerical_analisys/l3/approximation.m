% Given data points
years = [1940, 1950, 1955, 1960, 1970, 1980];
population = [122201, 132670, 150646, 179300, 202210, 224505];

% Points to interpolate
interp_years = [1965, 1990];

% Barycentric Lagrange interpolation
interp_population = barycentric_interpolation(years, population, interp_years);

% Display the results
fprintf('Approximate population in 1965: %.0f thousands\n', interp_population(1));
fprintf('Approximate population in 1990: %.0f thousands\n', interp_population(2));

% Barycentric Lagrange interpolation function
function p = barycentric_interpolation(x, y, x_interp)
    n = length(x);
    w = zeros(1, n);
    for j = 1:n
        w(j) = 1 / prod(x(j) - x([1:j-1, j+1:n]));
    end
    p = zeros(size(x_interp));
    for k = 1:length(x_interp)
        num = 0;
        denom = 0;
        for j = 1:n
            if x_interp(k) == x(j)
                p(k) = y(j);
                break;
            end
            term = w(j) / (x_interp(k) - x(j));
            num = num + term * y(j);
            denom = denom + term;
        end
        if x_interp(k) ~= x(j)
            p(k) = num / denom;
        end
    end
end
