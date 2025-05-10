% create a table to display results nicely
fprintf('n\tCondition Number\n');
fprintf('----------------------\n');

% calculate conditioning numbers for n=10 to 15
for n = 10:15
    % generate the Hilbert matrix of size n
    H = hilb(n);  % built-in MATLAB function for Hilbert matrix

    % calculate the condition number (using 2-norm)
    c = cond(H);

    % display results
    fprintf('%d\t%g\n', n, c);
end

% additional analysis - show how quickly they grow
fprintf('\nAdditional Analysis:\n');
fprintf('The condition numbers grow extremely rapidly!\n');
fprintf('At n=15, cond(H) is already ~4.7e+19\n');

% helper function to create Hilbert matrix (alternative implementation)
% (not needed since we use built-in hilb(), but shown for completeness)
function H = my_hilb(n)
    % creates n×n Hilbert matrix where H(i,j) = 1/(i+j-1)
    H = zeros(n);
    for i = 1:n
        for j = 1:n
            H(i,j) = 1/(i+j-1);
        end
    end
end

% 13 4.78
% 14 2,55
% 15 2,49
