function lfsig = Sig_P(config)

ang = config.lagp + (rand()*2-1)*config.randangp;
radang = deg2rad(ang);

AngStart = radang;

lfsig = 1/config.phfr*sin(2*pi*config.phfr*config.tsim + AngStart);