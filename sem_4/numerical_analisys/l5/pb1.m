% In the following table there are some data regarding a moving car. Use
% Hermite interpolation to estimate position and speed of the car when the time
% is t = 10.

% Time      0  3   5   8   13
% Distance  0  225 383 623 993
% Speed     75 77  80  74   72
% Given data
time = [0, 3, 5, 8, 13];
distance = [0, 225, 383, 623, 993];
speed = [75, 77, 80, 74, 72];

F_s = compute_divided_differences(time, distance, speed);
F_v = compute_divided_differences(time, speed, speed);

hermite_s = @(x) evaluate_poly(x, F_s, time);

hermite_v = @(x) evaluate_poly(x, F_v, time);

% estimate the position and speed at t = 10
t_eval = 10;
s_10 = hermite_s(t_eval);
v_10 = hermite_v(t_eval);

% Display results
fprintf('position at t = 10: %.6f\n', s_10);
fprintf('speed at t = 10: %.6f\n', v_10);
