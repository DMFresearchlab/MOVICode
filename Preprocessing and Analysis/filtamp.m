function [ampfilt, amp] = filtamp(rawdata, config)
srate = config.srate;
npnts = config.tp(end);
% fprintf('doing amplitude... ')
trl = 1;
%     showprogress(trl, size(rawdata, 1))
Hf1 = (config.amfr-config.amfr*.7)/2;% -high_freqs(hf)*.3;
Hf2 = (config.amfr+config.amfr*.7)/2;
ampfilt(trl, :) = eegfilt(squeeze(rawdata(trl, :)), srate, Hf1, Hf2);


amp(trl, :) = abs(hilbert(ampfilt(trl, :)));
end