function [phase amp] = filtphaseamp(rawdata, config)

srate = config.srate;
npnts = config.tp(end);
%% phase

% fprintf('doing phase... ')
for trl= 1:size(rawdata, 1)
%     showprogress(trl, size(rawdata, 1))
    Pf1 = config.phfr-(config.phfr*.4)/2;
    Pf2 = config.phfr+(config.phfr*.4)/2;
    if fix(config.srate/Pf1*2) > fix(config.tp(end)/3)
        filtorder = fix(config.tp(end)/3-1);
    else
        filtorder = fix(config.srate/config.phfr*2) ;
    end
    phasefilt(trl, :) = eegfilt(squeeze(rawdata(trl, :)), srate, Pf1, Pf2, npnts, filtorder);
end
%normalize phasefilt
switch config.norm
    case'norm'
%         fprintf('Normalizing ovec trials \n')
        Mphf = mean(phasefilt(:, :), 1);
        stdPhf = std(phasefilt(:, :), 1);
        for trl= 1:size(rawdata, 1)
            phasefilt(trl, :) = (phasefilt(trl, :)-Mphf)./stdPhf;
        end
end

for trl= 1:size(rawdata, 1)
    phase(trl, :) = angle(hilbert(phasefilt(trl, :)));
end

%% amplitude

% fprintf('doing amplitude... ')
for trl= 1:size(rawdata, 1)
%     showprogress(trl, size(rawdata, 1))
    Hf1 = (config.amfr-config.amfr*.7)/2;% -high_freqs(hf)*.3;
    Hf2 = (config.amfr+config.amfr*.7)/2;
    ampfilt(trl, :) = eegfilt(squeeze(rawdata(trl, :)), srate, Hf1, Hf2);
end
switch config.norm
    case'norm'
%         fprintf('Normalizing ovec trials \n')
        
        Mphf = mean(ampfilt(:, :), 1);
        stdPhf = std(ampfilt(:, :), 1);
        for trl= 1:size(rawdata, 1)
            ampfilt(trl, :) = (ampfilt(trl, :)-Mphf)./stdPhf;
        end
end
for trl= 1:size(ampfilt, 1)
    amp(trl, :) = abs(hilbert(ampfilt(trl, :))).^2;
end


% select data
tint = config.tint + config.trigtime;
npint = tint.*srate;
for trl = 1:size(amp, 1)
    ampcut(trl, :) = amp(trl, [npint(1):npint(end)]);
    phasecut(trl, :) = phase(trl, [npint(1):npint(end)]);
end
amp = ampcut;
phase = phasecut;
end
