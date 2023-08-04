% defaultsSim

%% fixed angle of start
%dataset 1
config.lagp1    = 0;    %lag for phase (at what phase does it begin, in degrees)
config.laga1    = 0;    %lag for amp (in degrees)

%dataset 2
config.lagp2    = 0;   
config.laga2    = 0;   


%% random angle of start
%dataset 1
config.randangp1        = R_angp; %random beginning angle of phase (in degrees)
config.randangamp1      = 90; %randonmess of beginining angle for amp
config.randangmod1      = R_angmod; %randomness of beginning angle for modulation

%dataset 2
config.randangp2        = R_angp; %random beginning angle of phase (in degrees)
config.randangamp2      = 90; %randonmess of beginining angle for amp
config.randangmod2      = R_angmod; %randomness of beginning angle for modulation

% config.noiseStr         = 0.5;

%% time, rate and timepoints
config.tint     = [0 2.5];
config.trigtime = 2;
config.time     = 6;           % time for length of trial, in seconds
config.srate    = 1000;          %sampling rate
config.tp       = 1:config.time*config.srate; %number of timepoints
config.tsim     = config.tp/config.srate;

