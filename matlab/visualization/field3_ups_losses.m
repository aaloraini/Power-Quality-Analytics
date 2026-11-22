% Field 3: UPS Losses (W)

readChannelID = 3590491;
fieldID1 = 3;
readAPIKey = '';   % channel is public, so no key is needed
numDays = 14;

%% Read Data 

[data, time] = thingSpeakRead(readChannelID, 'Field', fieldID1, 'NumDays', numDays, 'ReadKey', readAPIKey);
avgVal = mean(data, 'omitnan');

%% Visualize Data 

plot(time, data, '-', 'LineWidth', 1.4, 'Color', [0.80 0.33 0.10]);
hold on;
%yline(avgVal, '--', 'Mean', 'Color', [0.45 0.45 0.45], 'LabelHorizontalAlignment', 'left');
yline(avgVal, '--', 'Color', [0.45 0.45 0.45]);   % dashed line = mean (value shown in title)
hold off;
grid on;
xlabel('Date');
ylabel('UPS Losses (W)');
title({'UPS Conversion Losses, Chile', sprintf('Mean %.1f W   |   Min %.1f W   |   Max %.1f W', avgVal, min(data), max(data))});
