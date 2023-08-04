%presets for simulation

switch vari1
    case 'PAC'
        lab1 = 'PAC Strength';
        varparam1 = 0.8:-0.2:0;
        PACstrx = 1;
        v1 = 1;
    case 'Ntrials'
        lab1 = 'Number of trials';
        varparam1 = 10:10:50;
        PACstrx = 0;
        v1 = 2;
    case 'PN'
        lab1 = 'Pink Noise';
        varparam1 = (30:10:70)./25;
        PACstrx = 0;
        v1 = 3;
    case 'Angle'
        lab1 = 'Angle (degrees)';
        varparam1 = 0:45:180;
        PACstrx = 0;
        v1 = 4;
    case 'ITC1'
        lab1 = 'Inter Random Angle for phase';
        varparam1 = 0:45:180;
        PACstrx = 0;
        v1 = 5;
    case 'ITC2'
        lab1 = 'Inter Random Angle for modulation';
        varparam1 = 0:45:180;
        PACstrx = 0;
        v1 = 5;
end
switch vari2
    case 'PAC'
        lab2 = 'PAC Strength';
        varparam2 = 0.8:-0.2:0;
        PACstrx = 1;
        v2 = 1;
    case 'Ntrials'
        lab2 = 'Number of trials';
        varparam2 = 10:10:50;
        PACstrx = 0;
        v2 = 2;
    case 'PN'
        lab2 = 'Pink Noise';
        varparam2 =(30:10:70)./25;
        PACstrx = 0;
        
    case 'Angle'
        lab2 = 'Angle (degrees)';
        varparam2 = 0:45:180;
        PACstrx = 0;
        
    case 'ITC1'
        lab1 = 'Inter Random Angle for phase';
        varparam2 = 0:45:180;
        PACstrx = 0;
        
    case 'ITC2'
        lab1 = 'Inter Random Angle for modulation';
        varparam2 = 0:45:180;
        PACstrx = 0;
        
end

if config.lagmod1 == 0 && config.lagmod2 == 180
    opvar = 'opposed';
elseif config.lagmod1 == 0 && config.lagmod2 == 0
    opvar = 'samedir';
end
switch vari1
    case 'Angle'
        opvar = [];
end
switch vari2
    case 'Angle'
        opvar = [];
end
