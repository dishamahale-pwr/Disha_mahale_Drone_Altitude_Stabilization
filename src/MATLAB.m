clc;
clear;
close all;

%% Drone Altitude Stabilization Using PID Controller
% Input  : thrust command u(t)
% Output : altitude h(t)
% Plant  : G(s) = H(s)/U(s) = 1 / (s^2 + 2s + 5)

s = tf('s');

G = 1 / (s^2 + 2*s + 5);

disp('Drone Altitude Transfer Function:');
G

%% Open-loop response
figure;
step(G);
grid on;
title('Open-Loop Step Response');
xlabel('Time (seconds)');
ylabel('Altitude h(t)');

open_loop_info = stepinfo(G);

disp('Open-Loop Performance Metrics:');
disp(open_loop_info);

%% PID Controller Parameters
Kp = 70;
Ki = 20;
Kd = 11;

C = pid(Kp, Ki, Kd);

disp('PID Controller:');
C

%% Closed-loop response
T = feedback(C*G, 1);

figure;
step(T);
grid on;
title('Closed-Loop Step Response with PID Controller');
xlabel('Time (seconds)');
ylabel('Altitude h(t)');

closed_loop_info = stepinfo(T);
ess = abs(1 - dcgain(T));

disp('Closed-Loop Performance Metrics:');
disp(closed_loop_info);
fprintf('Steady-State Error = %.6f\n', ess);

%% Stability check
closed_loop_poles = pole(T);

disp('Closed-Loop Poles:');
disp(closed_loop_poles);

if all(real(closed_loop_poles) < 0)
    disp('Closed-loop system is stable.');
else
    disp('Closed-loop system is unstable.');
end

%% Disturbance response
% Disturbance is added at plant input at t = 5 seconds

T_ref = feedback(C*G, 1);
T_dist = feedback(G, C);

t = 0:0.01:10;

reference = ones(size(t));

disturbance = zeros(size(t));
disturbance(t >= 5) = 0.5;

y_ref = lsim(T_ref, reference, t);
y_dist = lsim(T_dist, disturbance, t);

y_total = y_ref + y_dist;

figure;
plot(t, y_total, 'b', 'LineWidth', 1.8);
hold on;
yline(1, 'r--', 'Reference Altitude');
xline(5, 'k--', 'Wind Disturbance Applied');
grid on;

xlabel('Time (seconds)');
ylabel('Altitude h(t)');
title('Closed-Loop Altitude Response with Wind Disturbance');
legend('Altitude Output h(t)', 'Reference h_{ref}(t)', 'Location', 'Best');

%% Requirement check
fprintf('\nRequirement Check:\n');
fprintf('Overshoot = %.2f %%\n', closed_loop_info.Overshoot);
fprintf('Settling Time = %.2f s\n', closed_loop_info.SettlingTime);
fprintf('Steady-State Error = %.6f\n', ess);

if closed_loop_info.Overshoot < 10
    disp('Overshoot requirement satisfied.');
else
    disp('Overshoot requirement NOT satisfied.');
end

if closed_loop_info.SettlingTime < 3
    disp('Settling time requirement satisfied.');
else
    disp('Settling time requirement NOT satisfied.');
end

if ess < 0.02
    disp('Steady-state error requirement satisfied.');
else
    disp('Steady-state error requirement NOT satisfied.');
end

if all(real(closed_loop_poles) < 0)
    disp('Stability requirement satisfied.');
else
    disp('Stability requirement NOT satisfied.');
end

