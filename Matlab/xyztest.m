% 清除之前的变量
clear all;
close all;
clc;

% ========== 定义三个方向的多项式系数 ==========
x_coeffs = [0, 1.6241e-15, 0, 3.24256e-17, 0.273438, -0.164063, 0.0341797, -0.00244141, ...
            1, 1.09375, -1.66533e-15, -0.273438, 3.94746e-16, 0.0410156, -5.1317e-16, -0.00244141];
y_coeffs = [0, 1.29928e-14, 0, 1.18424e-15, 0.875, -0.7875, 0.240625, -0.025, ...
            1, 5.56592e-15, -1.05, -4.73695e-15, 0.4375, -8.28967e-15, -0.109375, 0.025];
z_coeffs = [0, 5.41366e-15, 0, 5.92119e-16, 0.574219, -0.475781, 0.137402, -0.0137207, ...
            1, 0.546875, -0.525, -0.136719, 0.21875, 0.0205078, -0.0546875, 0.0112793];

% 分段系数
x_poly1 = x_coeffs(1:8);   x_poly2 = x_coeffs(9:16);
y_poly1 = y_coeffs(1:8);   y_poly2 = y_coeffs(9:16);
z_poly1 = z_coeffs(1:8);   z_poly2 = z_coeffs(9:16);

% ========== 时间参数 ==========
t_connection = 2.0;
t_total = 4.0;
t_seg1 = linspace(0, t_connection, 200);
t_seg2 = linspace(t_connection, t_total, 200);
t_seg2_shifted = t_seg2 - t_connection;

% ========== 计算三维轨迹 ==========
x1 = polyval(flip(x_poly1), t_seg1); x2 = polyval(flip(x_poly2), t_seg2_shifted);
y1 = polyval(flip(y_poly1), t_seg1); y2 = polyval(flip(y_poly2), t_seg2_shifted);
z1 = polyval(flip(z_poly1), t_seg1); z2 = polyval(flip(z_poly2), t_seg2_shifted);

% ========== 创建主图 ==========
figure('Position', [50, 50, 1000, 800]);
hold on;
grid on;
box on;

% 绘制轨迹
plot3(x1, y1, z1, 'b-', 'LineWidth', 3.5, 'Color', [0, 0.4470, 0.7410]);
plot3(x2, y2, z2, 'r-', 'LineWidth', 3.5, 'Color', [0.8500, 0.3250, 0.0980]);

% 标记关键点
plot3(x1(1), y1(1), z1(1), 'o', 'MarkerSize', 12, ...
      'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
plot3(x1(end), y1(end), z1(end), 'o', 'MarkerSize', 15, ...
      'MarkerFaceColor', [0.9290, 0.6940, 0.1250], 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
plot3(x2(end), y2(end), z2(end), 's', 'MarkerSize', 12, ...
      'MarkerFaceColor', [0.6350, 0.0780, 0.1840], 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);

% 添加时间颜色映射（不改变坐标轴范围）
time_points = [t_seg1, t_seg2];
x_points = [x1, x2];
y_points = [y1, y2];
z_points = [z1, z2];

% 设置固定坐标轴范围
x_range = [min(x_points)-0.1, max(x_points)+0.1];
y_range = [min(y_points)-0.1, max(y_points)+0.1];
z_range = [min(z_points)-0.1, max(z_points)+0.1];

xlim(x_range);
ylim(y_range);
zlim(z_range);

% 添加半透明的时间颜色点
scatter3(x_points, y_points, z_points, 30, time_points, 'filled', ...
         'MarkerEdgeAlpha', 0.2, 'MarkerFaceAlpha', 0.2);

% 设置标签和图例
xlabel('X 方向', 'FontSize', 13, 'FontWeight', 'bold');
ylabel('Y 方向', 'FontSize', 13, 'FontWeight', 'bold');
zlabel('Z 方向', 'FontSize', 13, 'FontWeight', 'bold');
title('三维 Minimum Snap 轨迹 (0-4秒)', 'FontSize', 15, 'FontWeight', 'bold');

% 添加颜色条
cb = colorbar;
cb.Label.String = '时间 (秒)';
cb.Label.FontSize = 11;
cb.Label.FontWeight = 'bold';

% 设置视角
view(45, 30);

% 添加光照
light('Position', [1, 1, 1], 'Style', 'infinite');
lighting gouraud;

% 图例
legend({'第一段: 0→2秒', '第二段: 2→4秒', '起点 (t=0)', '连接点 (t=2s)', '终点 (t=4s)'}, ...
       'Location', 'best', 'FontSize', 10);