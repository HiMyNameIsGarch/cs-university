% In the following table there are some data regarding a moving car.

% Time      (in s)       0  3   5   8   13
% Distance  (in feet)    0  225 383 623 993
% Speed     (in feet=s)  75 77  80  74   72

% Use a clamped cubic spline to predict the position of the car and its speed
% when the time is t = 10s.

time = [0 3 5 8 13]; % in seconds
distance = [0 225 383 623 993]; % in feet
speed = [75 77 80 74 72]; % in feet/s

deriv_at_start = 75; % speed at t=0
deriv_at_end = 72; % speed at t=13

spline_distance = spline(time, [deriv_at_start, distance, deriv_at_end]);

% Evaluate distance at t=10
t_eval = 10;
distance_at_10 = ppval(spline_distance, t_eval);

breaks = spline_distance.breaks;
coefs = spline_distance.coefs;

interval = find(t_eval >= breaks(1:end-1) & t_eval < breaks(2:end));
interval = interval(end);

a = coefs(interval, 1);
b = coefs(interval, 2);
c = coefs(interval, 3);
d = coefs(interval, 4);

speed_at_10 = 3*a*(t_eval - breaks(interval))^2 + 2*b*(t_eval - breaks(interval)) + c;

% Display results
fprintf('Predicted position at t=10s: %.2f feet\n', distance_at_10);
fprintf('Predicted speed at t=10s: %.2f ft/s\n', speed_at_10);

