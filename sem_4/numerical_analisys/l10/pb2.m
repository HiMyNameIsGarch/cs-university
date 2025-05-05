%-----------------------------------< Part a >-----------------------------------
% solve the original system and find conditioning number
A = [10 7 8 7;
     7 5 6 5;
     8 6 10 9;
     7 5 9 10];
b = [32; 23; 33; 31];

x = A\b; % solve original system
cond_num = cond(A); % calculate conditioning number

disp('point a:');
disp(x);
disp(['Conditioning number: ', num2str(cond_num)]);

%-----------------------------------< Part b >-----------------------------------
% solve perturbed system (b changed)
b_tilde = [32.1; 22.9; 33.1; 30.9];
x_tilde = A\b_tilde; % solve perturbed system

% calculate relative errors
input_rel_error_b = norm(b - b_tilde)/norm(b);
output_rel_error_b = norm(x - x_tilde)/norm(x);
error_ratio_b = output_rel_error_b/input_rel_error_b;

disp('point b:');
disp(['Input relative error (b): ', num2str(input_rel_error_b)]);
disp(['Output relative error (x): ', num2str(output_rel_error_b)]);
disp(['Error ratio: ', num2str(error_ratio_b)]);

%-----------------------------------< Part a >-----------------------------------
% solve system with perturbed A
A_bar = [10 7 8.1 7.2;
         7.08 5.04 6 5;
         8 5.98 9.89 9;
         6.99 4.99 9 9.98];
x_bar = A_bar\b; % solve system with perturbed A

% calculate relative errors
input_rel_error_A = norm(A - A_bar)/norm(A);
output_rel_error_A = norm(x - x_bar)/norm(x);
error_ratio_A = output_rel_error_A/input_rel_error_A;

disp('point c:');
disp(['Input relative error (A): ', num2str(input_rel_error_A)]);
disp(['Output relative error (x): ', num2str(output_rel_error_A)]);
disp(['Error ratio: ', num2str(error_ratio_A)]);

% helper function to calculate relative error between two vectors
function rel_error = relative_error(x, y)
    % calculates relative error between vectors x and y
    rel_error = norm(x - y) / norm(x);
end
