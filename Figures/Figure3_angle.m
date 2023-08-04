addpath('/media/ludovico/DATA/iEEG_Ludo/toolbox2.0/brewermap')
%% preset
clear
vari1 = 'Angle';
vari2 = 'PN';
opval1 = [];
nsubj = 100;
filename1 = sprintf('Stats_2D_complete_%s_%s_%s_z.mat', vari1, vari2, opval1);
ResDir = '/media/ludovico/DATA/iEEG_Ludo/SimToolbox/Results';

file1 = fullfile(ResDir, filename1);




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

%% Compare sensitivity
%Binomial test to compare sensitivity. As per Trevethan et al. 2017
%Sensitivity = Hits/(hits+false negatives). In the case of our test Hits =
%sensitivity because misses = 1-hits and the sum of hits and 1-hits is 1. 
%Binomial test to see the difference of sensitivity between MOVI and JSD. 




file1 = fullfile(ResDir, filename1);

load(file1);
BinomialTest;
tvals1 = tvals; 
pvals1 = pvals;

%Bonferroni correction
pvals1 = pvals1*(size(pvals1, 1)*size(pvals1, 2));

HitsMOVI(HitsMOVI == 1)= HitsMOVI(HitsMOVI ==1) -0.0001;
HitsJSD(HitsJSD==1) = HitsJSD(HitsJSD==1) -0.0001;
HitsJSD(HitsJSD ==0) = HitsJSD(HitsJSD==0) +0.0001;


MOVI_sensitivity = HitsMOVI;
JSD_sensitivity = HitsJSD;


diffSS = MOVI_sensitivity-JSD_sensitivity;

% MOVIss = norminv(HitsMOVI)-norminv(FASMOVI);
% SsJSD = norminv(HitsJSD)-norminv(FASJSD);
% % diffSS = MOVIss-SsJSD;
% BettPerc = (MOVIss-SsJSD)./JSD*100-100;

mask1 = pvals1 < 0.05;

Preset_Sim;
figure('units','normalized','outerposition',[0 0 0.8 0.4]) 
subplot(1, 3, 1) 
imagesc(varparam1, varparam2, MOVI_sensitivity')
set(gca, 'Ydir', 'normal')
title(sprintf('Hits MOVI for \n in function of angle difference'))
xlabel(xlab)
ylabel(ylab)
colormap(gca, 'parula')
caxis([0 1])
c = colorbar;
c.Label.String = 'Proportion of Hits';

subplot(1, 3, 2)
imagesc(varparam1, varparam2, JSD_sensitivity')
set(gca, 'Ydir', 'normal')
title(sprintf('Hits JSD for \n in function of angle differenc'))
xlabel(xlab)
ylabel(ylab)
colormap(gca, 'parula')
caxis([0 1])
c = colorbar;
c.Label.String = 'Proportion of Hits';

subplot(1, 3, 3)
imagesc(varparam1, varparam2, diffSS')
hold on;
contour(varparam1, varparam2, mask1', 1, 'linecolor', 'k', 'linewidth', 2);
set(gca, 'Ydir', 'normal')
title(sprintf('Difference in Sensitivity \n in function of angle differenc'))
xlabel(xlab)
ylabel(ylab)
colormap(gca, flipud(brewermap([], 'RdBu')))
caxis([-1 1])
c = colorbar;
c.Label.String = 'Difference in Hits';


set(gcf, 'color', 'white');
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
