function [phasefilt] = filtphase(rawdata, config)
srate = config.srate;
npnts = config.tp(end);
%% phase

% fprintf('doing phase... ')
trl = 1;
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