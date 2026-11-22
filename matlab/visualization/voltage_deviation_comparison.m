% Voltage deviation comparison: Chile UPS vs Austria smart meter


readChannelID = 3590491;   % our public channel, no read key needed
numDays       = 14;

% Field 4 = UPS (Chile) voltage deviation %, Field 7 = SM (Austria) voltage deviation %
[data, time] = thingSpeakRead(readChannelID, 'Fields', [4 7], 'NumDays', numDays);

dV_chile   = data(:,1);
dV_austria = data(:,2);

%__________________________________________________Plot
plot(time, dV_chile,   '-', 'LineWidth', 1.4, 'Color', [0.80 0.33 0.10]); hold on;
plot(time, dV_austria, '-', 'LineWidth', 1.4, 'Color', [0.25 0.36 0.27]);

yline( 10, '--', '+10% limit', 'Color', [0.6 0 0], 'LabelHorizontalAlignment', 'left', 'LabelVerticalALignment', 'bottom');
yline(-10, '--', '-10% limit', 'Color', [0.6 0 0], 'LabelHorizontalAlignment', 'left');
yline(  0, ':',  'Color', [0.4 0.4 0.4]);
hold off;

ylim([-12 12]);
grid on;
xlabel('Date');
ylabel('Voltage deviation from nominal (%)');
title('Supply Voltage Deviation: Chile (220 V) vs Austria (230 V)');
legend('Chile UPS input', 'Austria 3-phase average', 'Location', 'southeast');

%___________________________________________________ output window
fprintf('Chile:   mean %+.2f %%, min %+.2f %%, max %+.2f %%\n', ...
    mean(dV_chile,'omitnan'), min(dV_chile), max(dV_chile));
fprintf('Austria: mean %+.2f %%, min %+.2f %%, max %+.2f %%\n', ...
    mean(dV_austria,'omitnan'), min(dV_austria), max(dV_austria));
