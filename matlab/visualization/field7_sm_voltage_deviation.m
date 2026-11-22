% Field 7: SM Voltage Deviation (%)

readChannelID = 3590491;
fieldID1 = 7;
readAPIKey = '';   % channel is public, so no key is needed
numDays = 14;

%% Read Data

[data, time] = thingSpeakRead(readChannelID, 'Field', fieldID1, 'NumDays', numDays, 'ReadKey', readAPIKey);
avgVal = mean(data, 'omitnan');

%% Visualize Data

plot(time, data, '-', 'LineWidth', 1.4, 'Color', [0.25 0.36 0.27]);
hold on;
yline( 10, '--', '+10% limit (EN 50160)', 'Color', [0.60 0.00 0.00], 'LabelHorizontalAlignment', 'left', 'LabelVerticalALignment', 'bottom');
yline(-10, '--', '-10% limit (EN 50160)', 'Color', [0.60 0.00 0.00], 'LabelHorizontalAlignment', 'left');
yline(  0, ':', 'Color', [0.45 0.45 0.45]);
hold off;
ylim([-12 12]);
grid on;
xlabel('Date');
ylabel('SM Voltage Deviation (%)');
title({'Supply Voltage Deviation, Austria (230 V nominal)', sprintf('Mean %+.2f%%   |   Min %+.2f%%   |   Max %+.2f%%', avgVal, min(data), max(data))});
