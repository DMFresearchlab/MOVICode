function rawsig = Raw_s(config) 


[sigp config.angp]              = Sig_P_f(config);
sigamp                          = Sig_Amp_f(config);
sigmod                          = Sig_Mod(config);
noise                           = Sig_N_f(config);
noise2                          = (0.025*config.noiseSTR+0.001)*pinknoise(config.time*config.srate);

rawsig = (sigp+sigamp.*sigmod)+noise+noise2;
% rawsig = awgn(rawsig, 5, 0);
