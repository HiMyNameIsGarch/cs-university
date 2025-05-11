% create an array to store conditioning numbers
cond_numbers = zeros(6, 1); % for n=10 to 15 (6 values)

% loop through each matrix size
for n = 10:15
    % generate hilbert matrix of size n x n
    H = hilb(n); % built-in matlab function for hilbert matrix

    % calculate condition number (using 2-norm)
    cond_numbers(n-9) = cond(H);

    % display results for each n
    fprintf('n = %d, condition number = %e\n', n, cond_numbers(n-9));
end

% plot the condition numbers
figure;
plot(10:15, cond_numbers, '-o');
xlabel('matrix size n');
ylabel('condition number');
title('condition numbers of hilbert matrices H_n');
grid on;

% optional: display in table format
fprintf('\nsummary table:\n');
fprintf('n\tcondition number\n');
fprintf('-----------------------\n');
for i = 1:6
    fprintf('%d\t%e\n', i+9, cond_numbers(i));
end

% 13 4.78
% 14 2,55
% 15 2,49
