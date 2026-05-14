%% Robustness Test with Changed Drone Dynamics

% Original drone dynamics:
Drone = 1 / (s^2 + 2*s + 5);

% Modified drone dynamics to test robustness:
Drone_robust = 1 / (s^2 + 2.5*s + 6);

T_original = feedback(C * Drone, 1);
T_robust = feedback(C * Drone_robust, 1);

figure;
step(T_original, 'b', T_robust, 'm--');
grid on;
title('Robustness Test: Original vs Modified Drone Dynamics');
xlabel('Time');
ylabel('Altitude h(t)');
legend('Original Drone Dynamics', 'Modified Drone Dynamics');

info_original = stepinfo(T_original);
info_robust = stepinfo(T_robust);

disp('Original Drone Performance:');
disp(info_original);

disp('Modified Drone Performance:');
disp(info_robust);
