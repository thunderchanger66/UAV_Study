% 清除之前的变量
clear all;
close all;
clc;

% 定义多项式系数
coeffs = [0, 1.6241e-15, 0, 3.24256e-17, 0.273438, -0.164063, 0.0341797, -0.00244141, ...
          1, 1.09375, -1.66533e-15, -0.273438, 3.94746e-16, 0.0410156, -5.1317e-16, -0.00244141];

poly1 = coeffs(1:8);   % 第一段多项式系数 (t=0到2秒)
poly2 = coeffs(9:16);  % 第二段多项式系数 (t=2到5秒)

% 连接点时间
t1 = 2.0;

% 创建时间向量（更密集的点让曲线更平滑）
t_seg1 = linspace(0, t1, 300);    % 第一段：0到2秒
t_seg2 = linspace(t1, 4, 300);    % 第二段：2到5秒

% 计算多项式值
y_seg1 = polyval(flip(poly1), t_seg1);       % 第一段轨迹
y_seg2 = polyval(flip(poly2), t_seg2 - t1);  % 第二段轨迹（注意时间偏移）

% ========== 主要画图：完整的分段轨迹 ==========
figure('Position', [100, 100, 1000, 700]);

% 主图：完整轨迹
subplot(2,2,[1,2]);
plot(t_seg1, y_seg1, 'b-', 'LineWidth', 3.5, 'Color', [0, 0.4470, 0.7410]);  % MATLAB蓝色
hold on;
plot(t_seg2, y_seg2, 'r-', 'LineWidth', 3.5, 'Color', [0.8500, 0.3250, 0.0980]);  % MATLAB橙色

% 标记连接点
plot(t1, y_seg1(end), 'ko', 'MarkerSize', 16, 'MarkerFaceColor', [0.4660, 0.6740, 0.1880], ...
     'LineWidth', 2, 'MarkerEdgeColor', 'k');

% 标记起点和终点
plot(0, y_seg1(1), 's', 'MarkerSize', 12, 'MarkerFaceColor', 'b', 'LineWidth', 2, 'MarkerEdgeColor', 'k');
plot(4, y_seg2(end), 'd', 'MarkerSize', 12, 'MarkerFaceColor', 'r', 'LineWidth', 2, 'MarkerEdgeColor', 'k');

% 图形美化
grid on;
grid minor;
box on;
xlabel('时间 (秒)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('位置', 'FontSize', 14, 'FontWeight', 'bold');
title('分段多项式轨迹 (Minimum Snap轨迹)', 'FontSize', 16, 'FontWeight', 'bold');

% 设置坐标轴范围
xlim([-0.2, 4.2]);
ylim_range = [min([y_seg1, y_seg2]), max([y_seg1, y_seg2])];
ylim_margin = (ylim_range(2) - ylim_range(1)) * 0.1;
ylim([ylim_range(1)-ylim_margin, ylim_range(2)+ylim_margin]);

% 图例
legend({'段1: 0 → 2秒', '段2: 2 → 4秒', '连接点 (t=2s)', '起点 (t=0)', '终点 (t=4s)'}, ...
       'Location', 'best', 'FontSize', 11);

% 添加文本标注
text(1, mean(y_seg1), '7次多项式段1', 'HorizontalAlignment', 'center', ...
     'FontSize', 11, 'BackgroundColor', 'white', 'EdgeColor', 'blue');
text(3.5, mean(y_seg2), '7次多项式段2', 'HorizontalAlignment', 'center', ...
     'FontSize', 11, 'BackgroundColor', 'white', 'EdgeColor', 'red');

% 添加连接点信息
text(t1+0.1, y_seg1(end), sprintf('(2.00, %.4f)', y_seg1(end)), ...
     'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', ...
     'FontSize', 10, 'BackgroundColor', 'white');