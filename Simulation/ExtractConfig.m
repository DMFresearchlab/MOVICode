fp              = config.fp;     %frequency for phase
fa              = config.fa;    %frequency for amplitude
ntrials         = config.ntrials;

lagp            = config.lagp;    %lag for phase (at what phase does it begin, in degrees)
laga            = config.laga;    %lag for amp (in degrees)
lagmod          = config.lagmod;   %lag for modulatory phase of amp (in degrees)
%lagmod determines the direction of coupling of amplitude. 0 is in phase,
%180 is opposite phase. 

randangp        = config.randangp; %random beginning angle of phase (in degrees)
randangamp      = config.randangamp; %randonmess of beginining angle for amp
randangmod      = config.randangmod; %randomness of beginning angle for modulation

time            = config.time;  % time for length of trial, in seconds
srate           = config.srate;  %sampling rate
tp              = config.tp; %number of timepoints
PACstr          = config.PACstr;    %coupling strength. 1 is no coupling, 0 is strong coupling
