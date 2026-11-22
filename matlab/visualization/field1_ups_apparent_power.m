% Field 1: UPS Apparent Power (VA)

readChannelID = 3590491;
fieldID1 = 1;
readAPIKey = '';   % channel is public, so no key is needed
numDays = 14;

%% Read Data 

[data, time] = thingSpeakRead(readChannelID, 'Field', fieldID1, 'NumDays', numDays, 'ReadKey', readAPIKey);
avgVal = mean(data, 'omitnan');

%% Visualize Data

plot(time, data, '-', 'LineWidth', 1.4, 'Color', [0.80 0.33 0.10]);
hold on;
yline(avgVal, '--', 'Color', [0.45 0.45 0.45], 'LabelHorizontalAlignment', 'left');
hold off;
grid on;
xlabel('Date');
ylabel('UPS Apparent Power (VA)');
title({'UPS Apparent Power, Chile', sprintf('Mean %.1f VA   |   Min %.1f VA   |   Max %.1f VA', avgVal, min(data), max(data))});
