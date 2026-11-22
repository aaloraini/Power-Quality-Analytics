% Field 8: SM Net Power (W)

readChannelID = 3590491;
fieldID1 = 8;
readAPIKey = '';   % channel is public, so no key is needed
numDays = 14;

%% Read Data 

[data, time] = thingSpeakRead(readChannelID, 'Field', fieldID1, 'NumDays', numDays, 'ReadKey', readAPIKey);
avgVal = mean(data, 'omitnan');

%% Visualize Data 

plot(time, data, '-', 'LineWidth', 1.4, 'Color', [0.25 0.36 0.27]);
hold on;
yline(0, ':', 'Color', [0.45 0.45 0.45], 'LabelHorizontalAlignment', 'left');
hold off;
grid on;
xlabel('Date');
ylabel('SM Net Power (W)');
title({'Net Grid Power, Austria', sprintf('Mean %.0f W   |   Min %.0f W   |   Max %.0f W', avgVal, min(data), max(data))});
