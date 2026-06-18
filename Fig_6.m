clc;
clear all;
close all;

n = 10:5:50;

% without EMI
y1 = [741.882691017807 894.443786313948 1008.32005401372 1094.61955944895 1164.50901525747 1226.26422807115 1285.16410809692 1334.00456137166 1369.63891787718];
y2 = [741.804239642364 894.711608223481 1014.36325912504 1102.61579604314 1171.02338644612 1220.52017554333 1285.85257642763 1331.69994815686 1369.71500061268];
y3 = [744.586015875971 888.716099693173 1008.68114932512 1092.17497192954 1185.93563085066 1231.17824981261 1276.67470669049 1324.63851334193 1374.83359343681];

% with EMI
y4 = [677.824607559814 758.832264151705 803.022017565987 827.118530743336 839.816188419039 850.249726145236 856.949007346286 862.481787103797 863.860252939091];
y5 = [733.814593540852 874.884119038077 978.719056719035 1048.52388694321 1098.14965443154 1130.54569373657 1171.72646458893 1193.74607185642 1211.38730104068];
y6 = [743.752927673044 886.712041792151 1004.82981974712 1086.26219843131 1176.77014992017 1219.76728530913 1262.01915334533 1306.26949413438 1352.19188888252];

% AO Optimization without EMI
y7 = [2381.43088360989 2474.02869612064 2477.28712145942 2494.56756958894 2522.67888773683 2597.86327995386 2750.69518042283 2734.50349212396 2665.11517206258];

% AO Optimization with EMI
y10 = [2052.05430107581 2260.80134023454 2351.20317041274 2400.99345710773 2437.34343978234 2471.24748908278 2537.10389341270 2549.65771792620 2545.84426821474];
y11 = [2336.61910349229 2424.69349747844 2465.52287185432 2479.34348887661 2514.87016217356 2600.80287968570 2567.76476142056 2643.29327223182 2640.73994402622];

%% === Smooth curves (WITHOUT spline) ===
% Moving average window = 3
y1_s  = smooth(y1,  6, 'moving');
y7_s  = smooth(y7,  8, 'moving');
y4_s  = smooth(y4,  6, 'moving');
y5_s  = smooth(y5,  6, 'moving');
y10_s = smooth(y10, 6, 'moving');
y11_s = smooth(y11, 6, 'moving');

%% === Plot ===
figure;
hold on;

% Color codes
red  = [0.8500 0.3250 0.0980];
blue = [0 0.4470 0.7410];   % IEEE blue

% Smoothed curves with markers on real points
% Without EMI
semilogy(n, y1_s, '-o', 'Color', red, 'LineWidth', 1.2, 'MarkerFaceColor', 'none');
semilogy(n, y7_s, '-o', 'Color', red, 'LineWidth', 1.2, 'MarkerFaceColor', 'none');

% With EMI
semilogy(n, y4_s,  '-.^', 'Color', blue, 'LineWidth', 1.2, 'MarkerFaceColor', 'none');
semilogy(n, y5_s,  '--h', 'Color', blue, 'LineWidth', 1.2, 'MarkerFaceColor', 'none');
semilogy(n, y10_s, '-.^', 'Color', blue, 'LineWidth', 1.2, 'MarkerFaceColor', 'none');
semilogy(n, y11_s, '--h', 'Color', blue, 'LineWidth', 1.2, 'MarkerFaceColor', 'none');

% Axis settings
ylim([677 2900]);
xlabel('Number of elements (per dimension)', 'Interpreter', 'latex');
ylabel('Average SINR', 'Interpreter', 'latex');
grid on; box on;

% Legend markers
h1 = plot(nan, nan, 'o', 'Color', red,  'MarkerSize', 10, 'LineStyle', 'none');
h2 = plot(nan, nan, '^', 'Color', blue, 'MarkerSize', 10, 'LineStyle', 'none');
h3 = plot(nan, nan, 'h', 'Color', blue, 'MarkerSize', 10, 'LineStyle', 'none');

legend([h1, h2, h3], ...
       {'Without EMI', 'With EMI: $\rho = 10$', 'With EMI: $\rho = 20$'}, ...
       'Interpreter', 'latex', 'Location', 'best');
