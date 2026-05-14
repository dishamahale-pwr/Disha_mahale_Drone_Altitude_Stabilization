%% 3D Drone Altitude Animation

figure;
axis([-2 2 -2 2 0 1.5]);
grid on;
xlabel('X Position');
ylabel('Y Position');
zlabel('Altitude h(t)');
title('3D Drone Altitude Stabilization Animation');
view(45, 25);

hold on;

desired_altitude = 1;
plot3([-2 2], [0 0], [desired_altitude desired_altitude], ...
    'r--', 'LineWidth', 1.5);

drone_body = plot3(0, 0, 0, 'bo', ...
    'MarkerSize', 14, ...
    'MarkerFaceColor', 'b');

drone_arm1 = plot3([-0.3 0.3], [0 0], [0 0], 'k', 'LineWidth', 2);
drone_arm2 = plot3([0 0], [-0.3 0.3], [0 0], 'k', 'LineWidth', 2);

for i = 1:20:length(t)
    altitude = y_total(i);

    set(drone_body, 'XData', 0, 'YData', 0, 'ZData', altitude);

    set(drone_arm1, ...
        'XData', [-0.3 0.3], ...
        'YData', [0 0], ...
        'ZData', [altitude altitude]);

    set(drone_arm2, ...
        'XData', [0 0], ...
        'YData', [-0.3 0.3], ...
        'ZData', [altitude altitude]);

    drawnow;
    pause(0.02);
end

legend('Desired Altitude', 'Drone');

