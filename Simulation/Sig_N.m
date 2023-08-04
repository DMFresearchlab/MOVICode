function nsig = Sig_N(config)


randrad = (rand()*2-1)*180;

AngStart = deg2rad(randrad);


nsig = (1/config.amfr)*sin(2*pi*config.amfr*config.tsim +AngStart)*config.noiseStr;