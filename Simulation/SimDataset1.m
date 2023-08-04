config = SetConfig(config);


clear rawdata
rawdata1 = zeros(config.ntrials, config.tp(end));

for trl = 1:config.ntrials
    rawdata1(trl, :) = Raw_s(config);
end

rdavg1 = squeeze(mean(rawdata1, 1));

% Figure of raw data couple and uncoupled if many freqs involved 
% 
% figure;
% plot((rdavg1), 'b', 'linewidth', 1)
% title('all freqs')


%% filter 

%figure of filtered data all cond
[phase1 amp1] = filtphaseamp(rawdata1, config);

avgph1 = mean(phase1,1);
avgamp1 = mean(amp1, 1);
% 
% figure;
% subplot(211)
% plot(avgph1)
% subplot(212)
% plot(avgamp1)

% Figure of raw data couple and uncoupled if many freqs involved 
% 
% figure;
% plot((rdavg1), 'b', 'linewidth', 1)
% title('all freqs')

