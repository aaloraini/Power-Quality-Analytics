% Field 6: SM Voltage Unbalance (%)

readChannelID = 3590491;
fieldID1 = 6;
readAPIKey = '';   % channel is public, so no key is needed
numDays = 14;

%% Read Data

[data, time] = thingSpeakRead(readChannelID, 'Field', fieldID1, 'NumDays', numDays, 'ReadKey', readAPIKey);
avgVal = mean(data, 'omitnan');

%% Visualize Data

plot(time, data, '-', 'LineWidth', 1.4, 'Color', [0.25 0.36 0.27]);
hold on;
yline(2, '--', 'EN 50160 limit (2%)', 'Color', [0.60 0.00 0.00], 'LabelHorizontalAlignment', 'left', 'LabelVerticalAlignment', 'bottom');
hold off;
ylim([0 2.5]);
grid on;
xlabel('Date');
ylabel('SM Voltage Unbalance (%)');
title({'3-Phase Voltage Unbalance, Austria', sprintf('Mean %.2f%%   |   Min %.2f%%   |   Max %.2f%%', avgVal, min(data), max(data))});
