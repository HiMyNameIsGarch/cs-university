% Helper function to evaluate the polynomial
function y = evaluate_poly(x_eval, F, x_nodes)
    y = F(1,1);
    term = 1;
    n = length(x_nodes);
    for k = 2:n
        term = term * (x_eval - x_nodes(k-1));
        y = y + F(1,k) * term;
    end
end

