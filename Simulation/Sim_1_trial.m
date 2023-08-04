function [rawdat, phase, amp, mod] = Sim_1_trial(config)
%Waves have several characteristics and in the case of CFC we took example
%on the simulation of data of Tort et al. 2010 
%On this script are detailed all the characteristics taken into account for
%data simulation. 
ExtractConfig;

beganglep = deg2rad(lagp)+deg2rad((rand()*2-1)*randangp);
beganglea = deg2rad(laga)+deg2rad((rand()*2-1)*randangamp);
beganglem = deg2rad(lagmod)+deg2rad((rand()*2-1)*randangmod);

phase = (1/fp)*sin(beganglep+2*pi*fp*tp/srate);
amp = (1/fa)*sin(beganglea+2*pi*fa*tp/srate);
mod = ((1-PACstr)*sin(beganglem+2*pi*fp*tp/srate)+1+PACstr)/2;

rawdat = amp.*mod +phase;
end
