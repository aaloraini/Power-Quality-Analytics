% Field 4: UPS Voltage Deviation (%)

readChannelID = 3590491;
fieldID1 = 4;
readAPIKey = '';   % channel is public, so no key is needed
numDays = 14;

%% Read Data 

[data, time] = thingSpeakRead(readChannelID, 'Field', fieldID1, 'NumDays', numDays, 'ReadKey', readAPIKey);
avgVal = mean(data, 'omitnan');

%% Visualize Data 

plot(time, data, '-', 'LineWidth', 1.4, 'Color', [0.80 0.33 0.10]);
hold on;
yline( 10, '--', '+10% limit (EN 50160)', 'Color', [0.60 0.00 0.00], 'LabelHorizontalAlignment', 'left', 'LabelVerticalAlignment', 'bottom' );
yline(-10, '--', '-10% limit (EN 50160)', 'Color', [0.60 0.00 0.00], 'LabelHorizontalAlignment', 'left');
yline(  0, ':', 'Color', [0.45 0.45 0.45]);
hold off;
ylim([-12 12]);
grid on;
xlabel('Date');
ylabel('UPS Voltage Deviation (%)');
title({'Supply Voltage Deviation, Chile (220 V nominal)', sprintf('Mean %+.2f%%   |   Min %+.2f%%   |   Max %+.2f%%', avgVal, min(data), max(data))});
