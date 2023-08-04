function nsig = Sig_N_f(config)


randrad = deg2rad((rand()*2-1)*180);

AngStart = randrad;

lf = config.amfr - config.amfr*0.35;
hf = config.amfr + config.amfr*0.35;

fr = [lf config.phfr hf];
%random phase
nsig = zeros(1, length(config.tsim));
HFA = zeros(1, length(config.tsim));
for i = 1:length(fr)    
    HFA = HFA+  1/fr(i)*sin(AngStart+2*pi*fr(i)*config.tsim);
end
nsig = nsig + HFA;



lf = config.phfr - config.phfr*0.2;
hf = config.phfr + config.phfr*0.2;

fr = [lf config.phfr hf];
%random non modulated amplitude
for i = 1:length(fr)    
    nsig = nsig + 1/fr(i)*sin(AngStart+2*pi*fr(i)*config.tsim);
end
randrad = deg2rad((rand()*2-1)*180);


%random modulation
AngStart = randrad;

nsig = nsig + (((sin(2*pi*(config.phfr*config.modality)*config.tsim + AngStart)...
    *(1-config.PACstr)+1+config.PACstr)/4)).*HFA;
end
