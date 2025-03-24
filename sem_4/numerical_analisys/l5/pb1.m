% In the following table there are some data regarding a moving car. Use
% Hermite interpolation to estimate position and speed of the car when the time
% is t = 10.

% Time      0  3   5   8   13
% Distance  0  225 383 623 993
% Speed     75 77  80  74   72

% data from the table
time = [0 3 5 8 13];
distance = [0 225 383 623 993];
speed = [75 77 80 74 72];

% at time t = 10
t_query = 10;

% hermite interpolation for distance using pchip
distance_interp = pchip(time, distance, t_query);

% compute the derivative numerically:
% Small perturbation
delta = 1e-5;
distance_plus = pchip(time, distance, t_query + delta);
distance_minus = pchip(time, distance, t_query - delta);
speed_interp = (distance_plus - distance_minus) / (2 * delta);

% Display results
fprintf('position at t = 10: %.2f\n', distance_interp);
fprintf('speed at t = 10: %.2f\n', speed_interp);
