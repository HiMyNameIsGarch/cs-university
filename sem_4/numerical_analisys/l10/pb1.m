% solve the original system
A = [400 -201; -800 401];
b = [200; -200];
x = A\b; % using backslash operator to solve Ax = b
disp('point a:');
disp(x);

%-----------------------------------< Part b >-----------------------------------
% solve the modified system (A(1,1) changed from 400 to 401)
A_modified = [401 -201; -800 401];
x_modified = A_modified\b;
disp('point b:');
disp(x_modified);

%-----------------------------------< Part c >-----------------------------------
% find the conditioning number of the original matrix
cond_number = cond(A);
disp(['Conditioning number for original matrix: ', num2str(cond_number)]);


% let's see how much the solution changed with this small matrix change
error_in_solution = relative_error(x, x_modified);
disp(['Relative error in solution: ', num2str(error_in_solution)]);

% let's see how much we changed the matrix to understand sensitivity
error_in_matrix = norm(A - A_modified) / norm(A);
disp(['Relative error in matrix: ', num2str(error_in_matrix)]);

% calculate the error magnification factor
error_magnification = error_in_solution / error_in_matrix;
disp(['Error magnification factor: ', num2str(error_magnification)]);

% helper function to calculate relative error between two vectors
function rel_error = relative_error(x, y)
    % calculates relative error between vectors x and y
    rel_error = norm(x - y) / norm(x);
end
