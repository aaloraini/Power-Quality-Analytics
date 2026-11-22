% Field 2: UPS Power Factor

readChannelID = 3590491;
fieldID1 = 2;
readAPIKey = '';   % channel is public, so no key is needed
numDays = 14;

%% Read Data 

[data, time] = thingSpeakRead(readChannelID, 'Field', fieldID1, 'NumDays', numDays, 'ReadKey', readAPIKey);
avgVal = mean(data, 'omitnan');

%% Visualize Data 

plot(time, data, '-', 'LineWidth', 1.4, 'Color', [0.80 0.33 0.10]);
hold on;
yline(1, '--', 'Ideal PF = 1', 'Color', [0.45 0.45 0.45], 'LabelHorizontalAlignment', 'right', 'LabelVerticalAlignment', 'bottom');
hold off;
ylim([max(0, min(data) - 0.05), 1.05]);grid on;
xlabel('Date');
ylabel('UPS Power Factor');
title({'UPS Power Factor, Chile', sprintf('Mean %.3f   |   Min %.3f   |   Max %.3f', avgVal, min(data), max(data))});
