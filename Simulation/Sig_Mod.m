function modsig = Sig_Mod(config)

ang = config.angp+config.lagp+ config.lagmod + (rand()*2-1)*(config.randangmod/2);
%ang determines the angle of modulation by following the random angle of the
%phase (config.angp) for that trial, the set angle of the phase
%(config.lagp) and the set angle of the modulation(config.lagmod). This
%ensures that the modulation of the amplitude is always relative to the
%phase for a specific trial and if each trial has a random starting angle
%of phase this will not affect the average modulation. 


AngStart = deg2rad(ang);

lf = config.phfr - config.phfr*0.2;
hf = config.phfr + config.phfr*0.2;

fr = [lf config.phfr hf];

modsig = (((sin(2*pi*(config.phfr*config.modality)*config.tsim + AngStart)...
    *(1-config.PACstr)+1+config.PACstr)/2));

