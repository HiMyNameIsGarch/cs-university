% define the sets of data from the problem
years = [1940, 1950, 1955, 1960, 1970, 1980];
population = [122201, 132670, 150646, 179300, 202210, 224505];
interp_years = [1965, 1990];

% define the function with the sets of data
interp_population = barycentric_interpolation(years, population, interp_years);

fprintf('~ pop in 1965: %.0f thousands\n', interp_population(1));
fprintf('~ pop in 1990: %.0f thousands\n', interp_population(2));

% the barycentric interpolation is the division between 2 sums
% it is used to interpolate at a given point with a finite set of data
% in our case x(years), y(population) and x_interp(the interpolated years)
function p = barycentric_interpolation(x, y, x_interp)
    n = length(x);
    w = zeros(1, n); % place all the zeroes needed
    for j = 1:n % compute the A_i term from the formula (precompute)
        w(j) = 1 / prod(x(j) - x([1:j-1, j+1:n])); % j=/n the prod from j to n(x_j-x_i)
    end
    p = zeros(size(x_interp));% place all the zeroes needed
    for k = 1:length(x_interp)% start the main loop
        num = 0; % initial values
        denom = 0;
        for j = 1:n
            if x_interp(k) == x(j) % check the division by 0 (x - x_i)
                p(k) = y(j);
                break;
            end
            term = w(j) / (x_interp(k) - x(j)); % A_i / (x - x_i)
            num = num + term * y(j); % add the numerator -"- times the value at point j, y(j)
            denom = denom + term; % add the demominator from the previous value to the current one
        end
        if x_interp(k) ~= x(j) % if the values differ
            p(k) = num / denom; % final division for the interpolation
        end
    end
end
