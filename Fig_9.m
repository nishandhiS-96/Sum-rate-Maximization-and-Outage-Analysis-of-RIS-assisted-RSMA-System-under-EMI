% Combination of comparison of noma vs rsma and power allocation
clc;
clear all;
close all;
n = 0:2:40;
y1 = [1	0.0129520000000000	0.000682000000000000	0.000309000000000000	0.000220000000000000	0.000158000000000000	0.000143000000000000	0.000112000000000000	0.000119000000000000	9.30000000000000e-05	0.000102000000000000	7.20000000000000e-05	8.40000000000000e-05	8.20000000000000e-05	5.70000000000000e-05	7.00000000000000e-05	5.80000000000000e-05	5.20000000000000e-05	6.40000000000000e-05	4.70000000000000e-05	5.30000000000000e-05];
y2 = [1	0.170480000000000	0.0322200000000000	0.0161700000000000	0.0107500000000000	0.00782000000000000	0.00596000000000000	0.00489000000000000	0.00409000000000000	0.00347000000000000	0.00293000000000000	0.00304000000000000	0.00273000000000000	0.00257000000000000	0.00227000000000000	0.00223000000000000	0.00219000000000000	0.00199000000000000	0.00200000000000000	0.00190000000000000	0.00184000000000000];
y3 = [1	0.0280400000000000	0.00410400000000000	0.00242000000000000	0.00161500000000000	0.00127100000000000	0.00105600000000000	0.000890000000000000	0.000831000000000000	0.000795000000000000	0.000730000000000000	0.000658000000000000	0.000591000000000000	0.000562000000000000	0.000565000000000000	0.000500000000000000	0.000476000000000000	0.000490000000000000	0.000462000000000000	0.000464000000000000	0.000439000000000000];
y4 = [1	0.650960000000000	0.147460000000000	0.0769400000000000	0.0536300000000000	0.0411400000000000	0.0359300000000000	0.0324200000000000	0.0301800000000000	0.0277100000000000	0.0272100000000000	0.0250000000000000	0.0245300000000000	0.0233800000000000	0.0234600000000000	0.0224800000000000	0.0224700000000000	0.0226300000000000	0.0215500000000000	0.0203400000000000	0.0208400000000000];

% Plot with updated colors
semilogy(n, y1, '-o', 'Color', [0.85 0.33 0.10], 'LineWidth', 1.5, 'MarkerSize', 6); % Red-orange
hold on; grid on;
semilogy(n, y2, '-o', 'Color', [0.85 0.33 0.10], 'LineWidth', 1.5, 'MarkerSize', 6); % Red-orange
semilogy(n, y3, '-s', 'Color', [0.93 0.69 0.13], 'LineWidth', 1.5, 'MarkerSize', 6); % Golden yellow
semilogy(n, y4, '-s', 'Color', [0.93 0.69 0.13], 'LineWidth', 1.5, 'MarkerSize', 6); % Golden yellow

% Dummy plots for legend
h1 = semilogy(nan, nan, 'o', 'Color', [0.85 0.33 0.10], 'MarkerSize', 10);  % Red-orange
h2 = semilogy(nan, nan, 's', 'Color', [0.93 0.69 0.13], 'MarkerSize', 10);  % Golden yellow

% Legend
legend([h1, h2], ...
    {'Without EMI', 'With EMI'}, ...
    'Location', 'best', 'Interpreter', 'latex');

xlabel('Transmit Power (dBm)', 'Interpreter', 'latex');
ylabel('Outage Probability', 'Interpreter', 'latex');
set(gca, 'YScale', 'log');
grid on;



%%
% Combination of comparison of NOMA vs RSMA and power allocation
clc;
clear;
close all;

%% X-axis values
n = 0:2:40;

%% Data
y1 = [1 0.012952 0.000682 0.000309 0.000220 0.000158 0.000143 0.000112 ...
      0.000119 9.3e-05 0.000102 7.2e-05 8.4e-05 8.2e-05 5.7e-05 ...
      7.0e-05 5.8e-05 5.2e-05 6.4e-05 4.7e-05 5.3e-05];

y2 = [1 0.17048 0.03222 0.01617 0.01075 0.00782 0.00596 0.00489 ...
      0.00409 0.00347 0.00293 0.00304 0.00273 0.00257 0.00227 ...
      0.00223 0.00219 0.00199 0.00200 0.00190 0.00184];

y3 = [1 0.02804 0.004104 0.00242 0.001615 0.001271 0.001056 0.00089 ...
      0.000831 0.000795 0.00073 0.000658 0.000591 0.000562 ...
      0.000565 0.00050 0.000476 0.00049 0.000462 0.000464 ...
      0.000439];

y4 = [1 0.65096 0.14746 0.07694 0.05363 0.04114 0.03593 0.03242 ...
      0.03018 0.02771 0.02721 0.02500 0.02453 0.02338 ...
      0.02346 0.02248 0.02247 0.02263 0.02155 0.02034 ...
      0.02084];

%% Marker positions (only these x-values get markers)
markX = 0:10:40;
[~, markIdx] = ismember(markX, n);
markIdx(markIdx == 0) = [];

%% Proper smoothing (LOG-DOMAIN – IMPORTANT)
span = 0.3;   % 0.25–0.4 is safe for papers

y1_s = 10.^smooth(log10(y1), span, 'loess');
y2_s = 10.^smooth(log10(y2), span, 'loess');
y3_s = 10.^smooth(log10(y3), span, 'loess');
y4_s = 10.^smooth(log10(y4), span, 'loess');
%% IEEE-style colors
col1 = [0.85 0.33 0.10];        % Without EMI (red-orange)
col2 = [0 0.4470 0.7410];       % With EMI (IEEE blue)

%% Plot
figure;
hold on; box on; grid on;

% ---- Smoothed curves ----
semilogy(n, y1_s, '-.', 'Color', col1, 'LineWidth', 1.5);
semilogy(n, y2_s, '-.', 'Color', col1, 'LineWidth', 1.5);

semilogy(n, y3_s, '-', 'Color', col2, 'LineWidth', 1.5);
semilogy(n, y4_s, '-', 'Color', col2, 'LineWidth', 1.5);

% ---- Markers at selected x-values ----
semilogy(n(markIdx), y1(markIdx), 'o', 'Color', col1, ...
    'MarkerSize', 5, 'LineWidth', 1.2);
semilogy(n(markIdx), y2(markIdx), 'o', 'Color', col1, ...
    'MarkerSize', 5, 'LineWidth', 1.2);

semilogy(n(markIdx), y3(markIdx), '^', 'Color', col2, ...
    'MarkerSize', 5, 'LineWidth', 1.2);
semilogy(n(markIdx), y4(markIdx), '^', 'Color', col2, ...
    'MarkerSize', 5, 'LineWidth', 1.2);

% Dummy plots for legend (same colors)
h1 = semilogy(nan, nan, 'o', 'Color', col1, 'MarkerSize', 10);
h2 = semilogy(nan, nan, '^', 'Color', col2, 'MarkerSize', 10);

legend([h1, h2], {'Without EMI', 'With EMI'}, ...
       'Location', 'best', 'Interpreter', 'latex');

xlim([0 40]);
ylim([1e-5 1]);

xlabel('Transmit Power (dBm)', 'Interpreter', 'latex');
ylabel('Outage Probability', 'Interpreter', 'latex');
set(gca, 'YScale', 'log', 'FontSize', 12);
grid on;
