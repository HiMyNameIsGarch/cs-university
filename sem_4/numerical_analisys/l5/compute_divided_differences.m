function F = compute_divided_differences(x_nodes, f_values, df_values)
    n = length(x_nodes);

    F = zeros(n, n);
    % first column
    F(:,1) = f_values';

    for i = 1:n-1
        % if nodes are equal, use derivative
        if x_nodes(i) == x_nodes(i+1)
            F(i,2) = df_values(i);
        else
            nominator = F(i+1,1) - F(i,1);
            denominator = x_nodes(i+1) - x_nodes(i);
            F(i,2) = nominator / denominator;
        end
    end

    % higher order div diff
    for j = 3:n
        for i = 1:n-j+1
            nominator = F(i+1,j-1) - F(i,j-1);
            denominator = x_nodes(i+j-1) - x_nodes(i);
            F(i,j) = nominator / denominator;
        end
    end
end

