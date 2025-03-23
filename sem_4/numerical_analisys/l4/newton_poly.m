% newton polynomial function
function result = newton_poly(x_data, F_at_x, x)
    n = length(x_data);
    result = F_at_x(1, 1); % f(x_0)
    product = 1;
    for j = 2:n
        product = product .* (x - x_data(j - 1));
        result = result + F_at_x(1, j) * product;
    end
end
