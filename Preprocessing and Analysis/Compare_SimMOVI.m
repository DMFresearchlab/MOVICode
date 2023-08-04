%Compare SimMOVI PPV
addpath('/media/ludovico/DATA/iEEG_Ludo/toolbox2.0/brewermap')
%% preset
vari1 = 'Ntrials';
vari2 = 'PN';
opval1 = 'opposed';
opval2 = 'samedir';
nsubj = 100;
filename1 = sprintf('Stats_2D_complete_%s_%s_%s.mat', vari1, vari2, opval1);
filename2 = sprintf('Stats_2D_complete_%s_%s_%s.mat', vari1, vari2, opval2);
ResDir = '/media/ludovico/DATA/iEEG_Ludo/SimToolbox/Results';

file1 = fullfile(ResDir, filename1);
file2 = fullfile(ResDir, filename2);



load(file1);

signMOVI = zeros(size(pvalmovi));
cond = pvalmovi < 0.05 & tvalmovi > 0;
signMOVI = cond; 
signMOVI = squeeze(sum(signMOVI, 1));
signMOVI = signMOVI/nsubj;
signJSD = zeros(size(pvalJSD));
cond = pvalJSD < 0.05 & tvalmovi > 0;
signJSD = cond; 
signJSD = squeeze(sum(signJSD, 1));
signJSD = signJSD/nsubj;
HitsMOVI = signMOVI;
HitsJSD = signJSD;
% HitsMOVI(:, 2:2:end) = [];
% HitsJSD(:, 2:2:end) =[];

load(file2)

signMOVI = zeros(size(pvalmovi));
cond = pvalmovi < 0.05 & tvalmovi > 0;
signMOVI = cond; 
signMOVI = squeeze(sum(signMOVI, 1));
signMOVI = signMOVI/nsubj;
signJSD = zeros(size(pvalJSD));
cond = pvalJSD < 0.05 & tvalmovi > 0;
signJSD = cond; 
signJSD = squeeze(sum(signJSD, 1));
signJSD = signJSD/nsubj;
FASMOVI = signMOVI;
FASJSD = signJSD;

%% Compare sensitivity
%Binomial test to compare sensitivity. As per Trevethan et al. 2017
%Sensitivity = Hits/(hits+false negatives). In the case of our test Hits =
%sensitivity because misses = 1-hits and the sum of hits and 1-hits is 1. 
%Binomial test to see the difference of sensitivity between MOVI and JSD. 

filename1 = sprintf('Stats_2D_complete_%s_%s_%s.mat', vari1, vari2, opval1);
filename2 = sprintf('Stats_2D_complete_%s_%s_%s.mat', vari1, vari2, opval2);
ResDir = '/media/ludovico/DATA/iEEG_Ludo/SimToolbox/Results';

file1 = fullfile(ResDir, filename1);
file2 = fullfile(ResDir, filename2);
load(file1);
BinomialTest;
load(file2)
BinomialTest;







%% compare PPV with bar plot (avg matrix)


FASMOVI (FASMOVI ==0) = FASMOVI(FASMOVI ==0) +0.0001;
FASJSD(FASJSD == 0) = FASJSD(FASJSD == 0) +0.0001;
HitsMOVI(HitsMOVI == 1)= HitsMOVI(HitsMOVI ==1) -0.0001;
HitsJSD(HitsJSD==1) = HitsJSD(HitsJSD==1) -0.0001;
HitsJSD(HitsJSD ==0) = HitsJSD(HitsJSD==0) +0.0001;


MOVI_sensitivity = FASMOVI;
JSD_sensitivity = FASJSD;
MOVI_PPV = ((HitsMOVI)./((HitsMOVI)+(FASMOVI)))*100;
JSD_PPV = ((HitsJSD)./((HitsJSD)+FASJSD))*100;

P_MOVI = norminv(HitsMOVI)-norminv(FASMOVI);
P_JSD = norminv(HitsJSD)-norminv(FASJSD);

diff_P = (P_MOVI-P_JSD);

diffPPV = ((MOVI_PPV-JSD_PPV));
diffSS = MOVI_sensitivity-JSD_sensitivity;

% MOVIss = norminv(HitsMOVI)-norminv(FASMOVI);
% SsJSD = norminv(HitsJSD)-norminv(FASJSD);
% % diffSS = MOVIss-SsJSD;
% BettPerc = (MOVIss-SsJSD)./JSD*100-100;


figure;
imagesc(varparam1, varparam2, diffPPV')
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
title('PPV MOVI-JSD')
caxis([-100, 100])
colormap(flipud(brewermap([], 'RdBu')))
colorbar()


figure;
imagesc(varparam1, varparam2, diffSS')
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
title('Sensitivity MOVI-JSD')
caxis([-1, 1])
colormap(flipud(brewermap([], 'RdBu')))
colorbar()

figure;
imagesc(varparam1, varparam2, diff_P')
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
title('Probability MOVI-JSD')
caxis([-2, 2])
colormap(flipud(brewermap([], 'RdBu')))
colorbar()

%% Compare PPV
%Positive predictive value assesses how many of the positive tests are
%actually true positives (detects an effect when there is one) and tests
%whether the method is over sensitive. 
%PPV = true positives/(true positives + false positives)
%We calculate the difference of PPV between MOVI and JSD as 
%diff = PPV_MOVI-PPV_JSD. This will show us which tests is more predictive
%of a true positive. 

JSD_PPV_avg = mean(JSD_PPV, 'all');
JSD_PPV_std = std(JSD_PPV, [], 'all');
MOVI_PPV_avg = mean(MOVI_PPV, 'all');
MOVI_PPV_std = std(MOVI_PPV, [], 'all');

MOVI_PPV_SE = MOVI_PPV_std/sqrt(25);
JSD_PPV_SE = JSD_PPV_std/sqrt(25);

figure;
bar(1, MOVI_PPV_avg)
hold on

er1 = errorbar(1, MOVI_PPV_avg, -MOVI_PPV_SE, +MOVI_PPV_SE);
er1.Color = [0 0 0];                            
er1.LineStyle = 'none'; 
hold on;
bar(2, JSD_PPV_avg)
hold on
er2 = errorbar(2, JSD_PPV_avg, -JSD_PPV_SE, +JSD_PPV_SE);
er2.Color = [0 0 0];                            
er2.LineStyle = 'none'; 
title('Mean PPV for MOVI and JSD')
