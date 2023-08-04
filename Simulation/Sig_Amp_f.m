function hfsig = Sig_Amp_f(config)

ang = (config.laga) + (rand()*2-1)*config.randangamp;


AngStart = deg2rad(ang);

lf = config.amfr - config.amfr*0.35;
hf = config.amfr + config.amfr*0.35;

fr = [lf config.amfr hf];

% sigmod      = Sig_Mod(config);

hfsig = zeros(1, length(config.tsim));
for fi = 1:length(fr)
    hfsig = hfsig + 1/fr(1)*sin(AngStart+2*pi*fr(fi)*config.tsim);
end

