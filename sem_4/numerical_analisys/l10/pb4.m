%-----------------------------------< Part a >-----------------------------------
disp('point a: tk = 1/k');
fprintf('n\tCondition Number\n');
fprintf('----------------------\n');

for n = [10, 15]
    % create points tk = 1/k
    t = 1./(1:n)';

    % generate Vandermonde matrix
    V = vander(t);

    % calculate condition number
    c = cond(V);

    fprintf('%d\t%g\n', n, c);
end

%-----------------------------------< Part b >-----------------------------------
% Vandermonde matrices for tk = -1 + (2/n)*k, k=1..n
disp(' ');
disp('point b: tk = -1 + (2/n)*k');
fprintf('n\tCondition Number\n');
fprintf('----------------------\n');

for n = 10:15
    % create points tk = -1 + (2/n)*k
    t = -1 + (2/n)*(1:n)';

    % generate Vandermonde matrix
    V = vander(t);

    % calculate condition number
    c = cond(V);

    fprintf('%d\t%g\n', n, c);
end

% helper function to create Vandermonde matrix (alternative implementation)
function V = my_vander(t)
    % creates Vandermonde matrix from vector t
    n = length(t);
    V = zeros(n);
    for j = 1:n
        V(:,j) = t.^(n-j);
    end
end
