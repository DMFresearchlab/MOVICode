config = SetConfig(config);


clear rawdata
rawdata2 = zeros(config.ntrials, config.tp(end));

for trl = 1:config.ntrials
    rawdata2(trl, :) = Raw_s(config);
end

rdavg2 = squeeze(mean(rawdata2, 1));

% Figure of raw data couple and uncoupled if many freqs involved 
% 
% figure;
% plot((rdavg2), 'b', 'linewidth', 1)
% title('all freqs')


%% filter 

%figure of filtered data all cond
[phase2 amp2] = filtphaseamp(rawdata2, config);

avgph2 = mean(phase2,1);
avgamp2 = mean(amp2, 1);
% 
% figure;
% subplot(211)
% plot(avgph2)
% subplot(212)
% plot(avgamp2)

% Figure of raw data couple and uncoupled if many freqs involved 
% 
% figure;
% plot((rdavg2), 'b', 'linewidth', 1)
% title('all freqs')

