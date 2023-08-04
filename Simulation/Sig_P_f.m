function [lfsig angp] = Sig_P_f(config)

ang = (config.lagp) + (rand()*2-1)*config.randangp;


AngStart = deg2rad(ang);

lf = config.phfr - config.phfr*0.2;
hf = config.phfr + config.phfr*0.2;

fr = [lf config.phfr hf];

lfsig = zeros(1, length(config.tsim));
for i = 1:length(fr)    
    lfsig = lfsig + 1/fr(i)*sin(AngStart+2*pi*fr(i)*config.tsim);
end
angp= ang;
end