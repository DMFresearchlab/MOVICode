function hfsig = Sig_Amp(config)

ang = config.laga + (rand()*2-1)*(config.randangamp/2);
radang = deg2rad(ang);

AngStart = radang;

hfsig = (1/config.amfr)*sin(2*pi*config.amfr*config.tsim +AngStart);