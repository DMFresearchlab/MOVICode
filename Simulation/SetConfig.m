function config = SetConfig(config)
% defaultsSim
if config.dataset == 1
    config.lagp         = config.lagp1;
    config.laga         = config.laga1;
    config.lagmod       = config.lagmod1;
    config.randangp     = config.randangp1;
    config.randangamp   = config.randangamp1;
    config.randangmod   = config.randangmod1;
    config.PACstr       = config.PACstr1;
elseif config.dataset == 2
    config.lagp         = config.lagp2;
    config.laga         = config.laga2;
    config.lagmod       = config.lagmod2;
    config.randangp     = config.randangp2;
    config.randangamp   = config.randangamp2;
    config.randangmod   = config.randangmod2;
    config.PACstr       = config.PACstr2;
end

