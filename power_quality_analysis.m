% Enter your MATLAB Code below

% Our Channel
myChannelID = 3590491;
writeAPIKey = '************************';

% Source channels
upsID = 3055790; % UPS Channel ID
smID = 1816602; % smartmeter channel ID

windowMin = 60; % analysis window in min

Vnom_UPS = 220; % nominal supply voltage **Chile**
Vnom_SM = 230; % nominal supply voltage **Europe**

vals = NaN(1,8); % set fields values

% ____________________________________________Read from UPS
try
    ups = thingSpeakRead(upsID, 'Fields', [2 3 4 5 7], ... % fields [2=V_in,3=V_out,4=W,5=A,7=eff-%]
        'NumMinutes', windowMin, 'OutputFormat', 'matrix');
    Vin  = ups(:,1);  Vout = ups(:,2);  P = ups(:,3);
    I    = ups(:,4);  eff  = ups(:,5);

    % Analysis1_apparent power and power factor
    %   S = V_rms * I_rms,  PF = P / S
    S  = Vout .* I;
    PF = min(P ./ S, 1);                 % PF capped at 1
    PF(S <= 0) = NaN;

    % Analysis2_UPS conversion losses
    %   P_in = P_out / (eta/100),  P_loss = P_in - P_out
    eff(eff <= 0) = NaN;                 % ignore if no efficiency
    Ploss = P ./ (eff/100) - P;

    % Analysis3a_supply voltage deviation from nominal
    %   dV% = (V - V_nom) / V_nom * 100
    dV_ups = (Vin - Vnom_UPS) / Vnom_UPS * 100;

    vals(1) = mean(S,      'omitnan');
    vals(2) = mean(PF,     'omitnan');
    vals(3) = mean(Ploss,  'omitnan');
    vals(4) = mean(dV_ups, 'omitnan');
catch err
    fprintf('UPS read failed: %s\n', err.message);
end

%____________________________________ Read from SM
try
    sm = thingSpeakRead(smID, 'Fields', [5 6 7 8], ... % fields [5=net_power (W),6=V_L1,7=V_L2,8=V_L3]
        'NumMinutes', windowMin, 'OutputFormat', 'matrix');
    Pnet = sm(:,1);  V = sm(:,2:4);      % V = [L1 L2 L3]

    % Average phase voltage
    Vavg = mean(V, 2);

    % Analysis4_voltage unbalance **IEEE/NEMA line voltage unbalance rate**
    %   LVUR% = max|V_i - V_avg| / V_avg * 100
    VU = max(abs(V - Vavg), [], 2) ./ Vavg * 100;

    % Analysis3b_voltage deviation from nominal
    dV_sm = (Vavg - Vnom_SM) / Vnom_SM * 100;

    vals(5) = mean(Vavg,  'omitnan');
    vals(6) = mean(VU,    'omitnan');
    vals(7) = mean(dV_sm, 'omitnan');
    vals(8) = mean(Pnet,  'omitnan');
catch err
    fprintf('Smartmeter read failed: %s\n', err.message);
end

%__________________________________ Output results
names = {'UPS S (VA)','UPS PF','UPS losses (W)','UPS dV (%)', ...
         'SM Vavg (V)','SM unbalance (%)','SM dV (%)','SM Pnet (W)'};
for k = 1:8
    fprintf('Field %d  %-18s %10.3f\n', k, names{k}, vals(k));
end

%__________________________________ Export Valid values
ok = find(~isnan(vals));
if isempty(ok)
    disp('No data from either source in this window. Nothing written.');
else
    thingSpeakWrite(myChannelID, vals(ok), 'Fields', ok, ...
        'WriteKey', writeAPIKey);
    fprintf('Wrote %d field(s) to channel %d.\n', numel(ok), myChannelID);
end
