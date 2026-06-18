clc;
clear all;
close all;

% Define n and y values
n_full = 0:1:40; % Contains all integers from 0 to 40
y1 = [1 0.265 0.082 0.045 0.044 0.033 0.015 0.015 0.022 0.018 0.021 0.009 0.010 0.014 0.017 0.015 0.020 0.010 0.009 0.016 0.014 ...
      0.012 0.011 0.010 0.009 0.008 0.007 0.006 0.005 0.004 0.003 0.002 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001 0.001];

y2 = [1 0.460 0.144 0.063 0.053 0.036 0.042 0.036 0.048 0.035 0.029 0.035 0.031 0.031 0.031 0.023 0.021 0.019 0.025 0.035 0.026 ...
      0.024 0.022 0.021 0.019 0.018 0.017 0.016 0.015 0.014 0.013 0.012 0.011 0.010 0.009 0.008 0.007 0.006 0.005 0.004 0.003 0.002];

y3 = [1 0.706 0.215 0.139 0.106 0.113 0.093 0.080 0.065 0.065 0.064 0.074 0.063 0.074 0.070 0.055 0.055 0.058 0.063 0.055 0.049 ...
      0.048 0.047 0.046 0.045 0.044 0.043 0.042 0.041 0.040 0.039 0.038 0.037 0.036 0.035 0.034 0.033 0.032 0.031 0.030 0.029 0.028];

% Select n values
selected_n = [5, 15, 25, 35];

% Find indices
indices = find(ismember(n_full, selected_n));

% Extract corresponding y-values
y1_selected = y1(indices);
y2_selected = y2(indices);
y3_selected = y3(indices);

% Updated colors matching previous plot (blue, red-orange, yellow)
colors_mag = {[0 0.45 0.74], [0.85 0.33 0.10], [0.93 0.69 0.13]};

% Bar plot with reduced spacing
b = bar(selected_n, [y1_selected; y2_selected; y3_selected]', 'grouped', 'BarWidth', 1); % Keep everything else same

% Apply custom colors to each bar group
for i = 1:length(b)
    b(i).FaceColor = colors_mag{i};
end

% Formatting
grid on;
xlabel('\rho', 'FontSize', 12);
ylabel('Outage Probability', 'FontSize', 12);
ylim([1e-4 1e0]); % Same as 10^-4 to 10^0
set(gca, 'YScale', 'log'); % Log scale

% Add legend with box
lgd = legend('\lambda/2', '\lambda/4', '\lambda/6', 'Location', 'best');
lgd.Box = 'on'; % Correct capitalization



