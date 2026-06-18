clc;
clear;
close all;

% Data
n = 10:5:50;
y1 = [741.8827 894.4438 1008.3201 1094.6196 1164.5090 1226.2642 1285.1641 1334.0046 1369.6389];
y2 = [677.8246 758.8323 803.0220 827.1185 839.8162 850.2497 856.9490 862.4818 863.8603];
y3 = [340.4864 437.6930 517.1161 594.6843 655.0076 702.7550 760.4167 804.5139 842.4313];
y4 = [306.3475 352.3281 375.7622 392.7656 402.4693 406.8957 414.0247 417.9450 417.3369];

y5 = [2381.4309 2474.0287 2477.2871 2494.5676 2522.6789 2597.8633 2750.6952 2734.5035 2665.1152];
y6 = [2052.0543 2260.8013 2351.2032 2400.9935 2437.3434 2471.2475 2537.1039 2549.6577 2545.8443];
y7 = [418.3567 453.6000 473.5881 531.7577 501.0631 562.8025 666.6248 556.3071 638.0115];
y8 = [353.0385 392.6966 414.5669 433.2398 447.8098 461.8835 488.8569 498.3944 514.8887];

%% === Smooth curves (Savitzky–Golay filter — preserves shape) ===
y1_s = smooth(y1, 7, "sgolay");
y2_s = smooth(y2, 7, "sgolay");
y3_s = smooth(y3, 7, "sgolay");
y4_s = smooth(y4, 7, "sgolay");
y5_s = smooth(y5, 7, "sgolay");
y6_s = smooth(y6, 7, "sgolay");
y7_s = smooth(y7, 7, "sgolay");
y8_s = smooth(y8, 7, "sgolay");

%% === Plot ===
figure;
hold on;
set(gca, 'YScale', 'log'); % Logarithmic scale

% Plot smoothed curves (no markers here)
semilogy(n, y1_s, '-s', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1.5);
semilogy(n, y2_s, '--s', 'Color', [0.9290 0.6940 0.1250], 'LineWidth', 1.5);

semilogy(n, y3_s, '-h', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.5);
semilogy(n, y4_s, '--h', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.5);

semilogy(n, y5_s, '-o', 'Color', [0 0.4470 0.7410], 'LineWidth', 1.5);
semilogy(n, y6_s, '--o', 'Color', [0 0.4470 0.7410], 'LineWidth', 1.5);

semilogy(n, y7_s, '-^', 'Color', [0.4660 0.6740 0.1880], 'LineWidth', 1.5);
semilogy(n, y8_s, '--^', 'Color', [0.4660 0.6740 0.1880], 'LineWidth', 1.5);

% Axis labels
xlabel('Number of elements (per dimension)', 'Interpreter', 'latex');
ylabel('Achievable Sum Rate (dB)', 'Interpreter', 'latex');

% Log-scale Y-axis limits
ylim([10^1.75 10^3.5]);

% Grid and box
grid on;
box on;

% Hollow dummy markers for legend
h1 = plot(nan, nan, 'o', 'Color', [0 0.4470 0.7410], 'MarkerSize', 10, 'LineStyle', 'none');
h2 = plot(nan, nan, 's', 'Color', [0.9290 0.6940 0.1250], 'MarkerSize', 10, 'LineStyle', 'none');
h3 = plot(nan, nan, '^', 'Color', [0.4660 0.6740 0.1880], 'MarkerSize', 10, 'LineStyle', 'none');
h4 = plot(nan, nan, 'h', 'Color', [0.8500 0.3250 0.0980], 'MarkerSize', 10, 'LineStyle', 'none');

legend([h1, h2, h3, h4], ...
    {'RSMA-Alternating optimized Phase', ...
     'RSMA-Random Phase', ...
     'NOMA-Alternating optimized Phase', ...
     'NOMA-Random Phase'}, ...
     'Location', 'best');
