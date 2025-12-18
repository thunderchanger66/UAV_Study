% 1. 读取数据
data = readtable('trajectory_samples.csv');

figure;
plot3(data.x, data.y, data.z, 'b-', 'LineWidth', 2);
grid on; axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('三维轨迹');

figure;
scatter3(data.x, data.y, data.z, 50, 'filled');
grid on; axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');