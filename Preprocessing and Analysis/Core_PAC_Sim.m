%config simulation
%freqs of interest
clear
Home = '/media/ludovico/DATA/iEEG_Ludo/SimToolbox';
ResDir = 'Results';
addpath(Home)
addpath('/media/ludovico/DATA/iEEG_Ludo/SimToolbox')
addpath('/media/ludovico/DATA/iEEG_Ludo/toolbox2.0')


config.phfr = 5;      %phase freq
config.amfr = 80;     %amp freq
config.ntrials = 50;
nsubj = 100;
config.width = 1; %width of the modulation
config.lagmod1  = 0;    %dataset 1
config.lagmod2  = 0;  %dataset 2
%lagmod determines the direction of coupling of amplitude. 0 is in phase,
%180 is opposite phase.
R_angp = 45;
R_angmod = 45;
nbins = 18;
%determines the angle of randomness for the start of each trial.
%default is 90 degrees, within a 90 degrees frame trials will start at + or
%- 45 degrees from the angle of interest to introduce randomness. Change
%this setting in defaults_Sim.m
%determien angle of coupling
config.norm = 'no';
%Pac strength
config.PACstr1 =0.6; %put 0.6 to have same figures as in the paper where PAC is defined as 0.4 when fixed because this PACstr variable is actually 1-PACstr
config.PACstr2 = 0.6;
config.modality = 1;
config.noiseSTR = 2; %strength on noise, simulations showed that around 80 noise is too much and 0 is no pink noise.
rng('shuffle')
redosim = 1;
vari1 = 'ITC2';
vari2 = 'PN';

%% presets in function of settings
Preset_Sim;

simfile = sprintf('Stats_2D_complete_%s_%s_%s_z.mat', vari1, vari2, opvar);
simres = '/media/ludovico/DATA/iEEG_Ludo/SimToolbox/Results';
filesim = fullfile(simres, simfile);

xlab = lab1;
ylab = lab2;

defaults_Sim;
%% simulate data & calculate JSD and MOVI
if ~exist(filesim) || redosim == 1
    for subj = 1:nsubj
        showprogress(subj, nsubj)
        for var1 = 1:length(varparam1)
            for var2 = 1:length(varparam2)
                config.ntrials = 50;
                config.noiseSTR = varparam2(var2);
                config.randangmod1 = varparam1(var1);
                config.randangmod2 = varparam1(var1);
%                 config.PACstr2 = varparam1(var1);
%                 config.PACstr1 = varparam1(var1);
%                 config.lagmod2 = varparam1(var1);
                config.dataset = 1;
                SimDataset1;
%                 config.ntrials = varparam1(var1);

                config.dataset = 2;
                SimDataset2;
                
                
                
                %     PAC1;
                %     PAC2;
                Compute_MOVI;
                
                b1{subj, var1, var2} = binned1_exp;
                b2{subj, var1, var2} = binned2_exp;
                
               
                
              
                %show MI score and surrogate MI score for coupled freqs for MVL and DKL
                SMO = squeeze(MOVI_s);
                vM = MOVI;
                MOVI_c(subj, var1, var2) = (vM-mean(SMO))./std(SMO);
                tvalmovi = MOVI_c;
                SmoS = sort(SMO);
                [val idx] = min(abs(SmoS-vM));
                pvalmovi(subj, var1, var2) = 1-idx/length(SMO);
                
                SMO = squeeze(JSD_s);
                vM = (JSD);
                JSD_c(subj, var1, var2) = (vM-mean(SMO))./std(SMO);
                tvalJSD = JSD_c;
                SmoS = sort(SMO);
                [val idx] = min(abs(SmoS-vM));
                pvalJSD(subj, var1, var2) = 1-idx/length(SMO);
                
                %% MOVI
            end
        end
    end
    save(filesim)
else
    load(filesim)
end

signMOVI = zeros(size(pvalmovi));
cond = pvalmovi < 0.05 & tvalmovi > 0;
signMOVI = cond;
signMOVI = squeeze(sum(signMOVI, 1));
signMOVI = signMOVI/50;
signJSD = zeros(size(pvalJSD));
cond = pvalJSD < 0.05 & tvalmovi > 0;
signJSD = cond;
signJSD = squeeze(sum(signJSD, 1));
signJSD = signJSD/50;
v2 = varparam2(end:-1:1);


figure;
subplot(121)
imagesc(varparam1, varparam2, signMOVI')
set(gca, 'YDir', 'normal')
xlabel(xlab)
ylabel(ylab)
if PACstrx == 1
    hold on
    xline(0.45, 'linewidth', 2)
    hold on
    xline(0.7, 'linewidth', 2)
end
colorbar()
title('Hits MOVI')
caxis([0, 1])
subplot(122)
imagesc(varparam1, varparam2, signJSD')
set(gca, 'YDir', 'normal')
xlabel(xlab)
ylabel(ylab)
if PACstrx == 1
    hold on
    xline(0.45, 'linewidth', 2)
    hold on
    xline(0.7, 'linewidth', 2)
end
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
set(gcf, 'renderer', 'Painters')
set(gcf, 'color', 'white');
title('Hits JSD')
caxis([0, 1])
colorbar()

signDIFF = signMOVI-signJSD;

figure;
imagesc(varparam1, varparam2, signDIFF')
if PACstrx == 1
    hold on
    xline(0.45, 'linewidth', 2)
    hold on
    xline(0.7, 'linewidth', 2)
end
set(gca, 'YDir', 'normal')
xlabel(xlab)
ylabel(ylab)
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
set(gcf, 'renderer', 'Painters')
set(gcf, 'color', 'white');
title('Diff Hits')
caxis([-0.5, 0.5])
colorbar()


figure;
subplot(121)
contourf(varparam1, varparam2, squeeze(mean(MOVI_c))')
set(gca, 'YDir', 'normal')
xlabel(xlab)
ylabel(ylab)
if PACstrx == 1
    hold on
    xline(0.45, 'linewidth', 2)
    hold on
    xline(0.7, 'linewidth', 2)
end
colorbar()
title('T-Values MOVI')
caxis([-3, 3])
subplot(122)
contourf(varparam1, varparam2, squeeze(mean(JSD_c))')
set(gca, 'YDir', 'normal')
xlabel(xlab)
ylabel(ylab)
if PACstrx == 1
    hold on
    xline(0.45, 'linewidth', 2)
    hold on
    xline(0.7, 'linewidth', 2)
end
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
set(gcf, 'renderer', 'Painters')
set(gcf, 'color', 'white');
title('T-Values JSD')
caxis([-3, 3])
colorbar()


T_DIFF = squeeze(mean(MOVI_c))-squeeze(mean(JSD_c));

figure;
imagesc(varparam1, varparam2, T_DIFF')
set(gca, 'YDir', 'normal')
xlabel(xlab)
ylabel(ylab)
if PACstrx == 1
    hold on
    xline(0.45, 'linewidth', 2)
    hold on
    xline(0.7, 'linewidth', 2)
end
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
set(gcf, 'renderer', 'Painters')
set(gcf, 'color', 'white');
title('Diff Tvals')
caxis([-3, 3])
colorbar()