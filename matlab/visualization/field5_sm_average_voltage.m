% Field 5: SM Average Phase Voltage (V)

readChannelID = 3590491;
fieldID1 = 5;
readAPIKey = '';   % channel is public, so no key is needed
numDays = 14;

%% Read Data

[data, time] = thingSpeakRead(readChannelID, 'Field', fieldID1, 'NumDays', numDays, 'ReadKey', readAPIKey);
avgVal = mean(data, 'omitnan');

%% Visualize Data

plot(time, data, '-', 'LineWidth', 1.4, 'Color', [0.25 0.36 0.27]);
hold on;
yline(253, '--', '+10% (253 V)', 'Color', [0.60 0.00 0.00], 'LabelHorizontalAlignment', 'left', 'LabelVerticalAlignment', 'bottom');
yline(230, ':', 'Color', [0.45 0.45 0.45], 'LabelHorizontalAlignment', 'left');
yline(207, '--', '-10% (207 V)', 'Color', [0.60 0.00 0.00], 'LabelHorizontalAlignment', 'left');
hold off;
ylim([200 260]);
grid on;
xlabel('Date');
ylabel('SM Average Phase Voltage (V)');
title({'Average Phase Voltage, Austria', sprintf('Mean %.1f V   |   Min %.1f V   |   Max %.1f V', avgVal, min(data), max(data))});
