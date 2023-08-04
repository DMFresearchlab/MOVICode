addpath('/media/ludovico/DATA/iEEG_Ludo/toolbox2.0/brewermap')
%% preset
vari1 = 'PAC';
vari2 = 'PN';
opval1 = 'opposed';
opval2 = 'samedir';
nsubj = 100;
filename1 = sprintf('Stats_2D_complete_%s_%s_%s_z.mat', vari1, vari2, opval1);
filename2 = sprintf('Stats_2D_complete_%s_%s_%s_z.mat', vari1, vari2, opval2);
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

filename1 = sprintf('Stats_2D_complete_%s_%s_%s_z.mat', vari1, vari2, opval1);
filename2 = sprintf('Stats_2D_complete_%s_%s_%s_z.mat', vari1, vari2, opval2);
ResDir = '/media/ludovico/DATA/iEEG_Ludo/SimToolbox/Results';

file1 = fullfile(ResDir, filename1);
file2 = fullfile(ResDir, filename2);
load(file1);
BinomialTest;
tvals1 = tvals; 
pvals1 = pvals;
load(file2)
BinomialTest;
tvals2 = tvals; 
pvals2 = pvals;

pvals1 = pvals1*(size(pvals1, 1)*size(pvals1, 2));
pvals2 = pvals2*(size(pvals2, 1)*size(pvals2, 2));

FASMOVI (FASMOVI ==0) = FASMOVI(FASMOVI ==0) +0.0001;
FASJSD(FASJSD == 0) = FASJSD(FASJSD == 0) +0.0001;
HitsMOVI(HitsMOVI == 1)= HitsMOVI(HitsMOVI ==1) -0.0001;
HitsJSD(HitsJSD==1) = HitsJSD(HitsJSD==1) -0.0001;
HitsJSD(HitsJSD ==0) = HitsJSD(HitsJSD==0) +0.0001;


MOVI_sensitivity = HitsMOVI;
JSD_sensitivity = HitsJSD;
MOVI_PPV = ((HitsMOVI)./((HitsMOVI)+(FASMOVI)));
JSD_PPV = ((HitsJSD)./((HitsJSD)+FASJSD));
MOVI_NPV =(1-FASMOVI)./((1-FASMOVI)+(1-HitsMOVI));
JSD_NPV =(1-FASJSD)./((1-FASJSD)+(1-HitsJSD));

P_MOVI = (norminv(HitsMOVI)-norminv(FASMOVI));
P_JSD = (norminv(HitsJSD)-norminv(FASJSD));

diff_P = (P_MOVI-P_JSD);

diffPPV = ((MOVI_PPV-JSD_PPV));
diffSS = MOVI_sensitivity-JSD_sensitivity;
MPPV_lin = reshape(MOVI_PPV, 1, size(MOVI_PPV, 1)*size(MOVI_PPV, 2));
JSD_lin = reshape(JSD_PPV, 1, size(JSD_PPV, 1)*size(JSD_PPV, 2));
[h p ci stat] = ttest(MPPV_lin, JSD_lin);
mmPPV = mean(MOVI_PPV, 'all');
mjPPV = mean(JSD_PPV, 'all');

MNPV_lin = reshape(MOVI_NPV, 1, size(MOVI_NPV, 1)*size(MOVI_NPV, 2));
JSDN_lin = reshape(JSD_NPV, 1, size(JSD_NPV, 1)*size(JSD_NPV, 2));
[hn pn cin statn] = ttest(MNPV_lin, JSDN_lin);
mmNPV = mean(MOVI_NPV, 'all');
mjNPV = mean(JSD_NPV, 'all');

% MOVIss = norminv(HitsMOVI)-norminv(FASMOVI);
% SsJSD = norminv(HitsJSD)-norminv(FASJSD);
% % diffSS = MOVIss-SsJSD;
% BettPerc = (MOVIss-SsJSD)./JSD*100-100;

mask1 = pvals1 < 0.05;
mask2 = pvals2 < 0.05;
diffFAS = FASMOVI-FASJSD;

Preset_Sim;
figure('units','normalized','outerposition',[0 0 0.7 0.7])
subplot(2, 3, 1) 
imagesc(varparam1(end:-1:1), varparam2, MOVI_sensitivity')
set(gca, 'Ydir', 'normal')
title(sprintf('Hits MOVI for \n Opposed distributions'))
xlabel(xlab)
ylabel(ylab)
xticks([0 0.2 0.4 0.6 0.8])
xticklabels({'0.2', '0.4', '0.6', '0.8', '1'})
colormap(gca, 'parula')
caxis([0 1])
c = colorbar;
c.Label.String = 'Proportion of Hits';

subplot(2, 3, 2)
imagesc(varparam1(end:-1:1), varparam2, JSD_sensitivity')
set(gca, 'Ydir', 'normal')
title(sprintf('Hits JSD for \n Opposed distributions'))
xlabel(xlab)
ylabel(ylab)
xticks([0 0.2 0.4 0.6 0.8])
xticklabels({'0.2', '0.4', '0.6', '0.8', '1'})
colormap(gca, 'parula')
caxis([0 1])
c = colorbar;
c.Label.String = 'Proportion of Hits';

subplot(2, 3, 3)
imagesc(varparam1(end:-1:1), varparam2, diffSS')
hold on;
contour(varparam1(end:-1:1), varparam2, mask1', 1, 'linecolor', 'k', 'linewidth', 2);
set(gca, 'Ydir', 'normal')
title(sprintf('Difference in Sensitivity \n for Opposed distributions'))
xlabel(xlab)
ylabel(ylab)
xticks([0 0.2 0.4 0.6 0.8])
xticklabels({'0.2', '0.4', '0.6', '0.8', '1'})
colormap(gca, flipud(brewermap([], 'RdBu')))
caxis([-1 1])
c = colorbar;
c.Label.String = 'Difference of Hits';

subplot(2, 3, 4)
imagesc(varparam1(end:-1:1), varparam2, FASMOVI')
set(gca, 'Ydir', 'normal')
title(sprintf('Hits of MOVI for \n non-opposed distributions'))
xlabel(xlab)
ylabel(ylab)
xticks([0 0.2 0.4 0.6 0.8])
xticklabels({'0.2', '0.4', '0.6', '0.8', '1'})
colormap(gca, 'parula')
caxis([0 1])
c = colorbar;
c.Label.String = 'Proportion of False Alarms';


subplot(2, 3, 5)
imagesc(varparam1(end:-1:1), varparam2, FASJSD')
set(gca, 'Ydir', 'normal')
title(sprintf('Hits of JSD for \n non-opposed distributions'))
xlabel(xlab)
ylabel(ylab)
xticks([0 0.2 0.4 0.6 0.8])
xticklabels({'0.2', '0.4', '0.6', '0.8', '1'})
colormap(gca, 'parula')
caxis([0 1])
c = colorbar;
c.Label.String = 'Proportion of False Alarms';

subplot(2, 3, 6)
imagesc(varparam1(end:-1:1), varparam2, diffFAS')
hold on;
contour(varparam1(end:-1:1), varparam2, mask2', 1, 'linecolor', 'k', 'linewidth', 2);
set(gca, 'Ydir', 'normal')
title(sprintf('Difference in Sensitivity \n for non-opposed distributions'))
xlabel(xlab)
ylabel(ylab)
xticks([0 0.2 0.4 0.6 0.8])
xticklabels({'0.2', '0.4', '0.6', '0.8', '1'})
colormap(gca, flipud(brewermap([], 'RdBu')))
caxis([-1 1])
c = colorbar;
c.Label.String = 'Difference in False Alarms';



% subplot(3, 3, 7)
% imagesc(varparam1, varparam2, P_MOVI')
% set(gca, 'Ydir', 'normal')
% title(sprintf('d prime of MOVI for \n non-opposed distributions'))
% xlabel(xlab)
% ylabel(ylab)
% colormap(gca, 'parula')
% caxis([0 3])
% colorbar()
% 
% subplot(3, 3, 8)
% imagesc(varparam1, varparam2, P_JSD')
% set(gca, 'Ydir', 'normal')
% title(sprintf('d prime of JSD for \n non-opposed distributions'))
% xlabel(xlab)
% ylabel(ylab)
% colormap(gca, 'parula')
% caxis([0 3])
% colorbar()
% 
% subplot(3, 3, 9)
% imagesc(varparam1, varparam2, diff_P')
% hold on;
% % contour(varparam1, varparam2, mask2', 1, 'linecolor', 'k', 'linewidth', 2);
% set(gca, 'Ydir', 'normal')
% title(sprintf('Difference in d prime \n for non-opposed distributions'))
% xlabel(xlab)
% ylabel(ylab)
% colormap(gca, flipud(brewermap([], 'RdBu')))
% caxis([-2 2])
% colorbar()

set(gcf, 'color', 'white');
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);


MOVI_NPV =(1-FASMOVI)./((1-FASMOVI)+(1-HitsMOVI));
JSD_NPV =(1-FASJSD)./((1-FASJSD)+(1-HitsJSD));

MPPV_lin = reshape(MOVI_PPV, 1, size(MOVI_PPV, 1)*size(MOVI_PPV, 2));
JSD_lin = reshape(JSD_PPV, 1, size(JSD_PPV, 1)*size(JSD_PPV, 2));
[h p ci stat] = ttest(MPPV_lin, JSD_lin);
mmPPV = mean(MOVI_PPV, 'all');
mjPPV = mean(JSD_PPV, 'all');

MNPV_lin = reshape(MOVI_NPV, 1, size(MOVI_NPV, 1)*size(MOVI_NPV, 2));
JSDN_lin = reshape(JSD_NPV, 1, size(JSD_NPV, 1)*size(JSD_NPV, 2));
[hn pn cin statn] = ttest(MNPV_lin, JSDN_lin);
mmNPV = mean(MOVI_NPV, 'all');
mjNPV = mean(JSD_NPV, 'all');

accm =(mean(HitsMOVI, 'all')+(1-mean(FASMOVI, 'all')))/2;
accj =(mean(HitsJSD, 'all')+(1-mean(FASJSD, 'all')))/2;

mkm = mmPPV+mmNPV-1;
mkj = mjPPV+mjNPV-1;

mccm = sqrt(mmPPV*mean(HitsMOVI, 'all')*(1-mean(FASMOVI, 'all')*mmNPV))...
    -sqrt(mean(FASMOVI, 'all')*(1-mean(HitsMOVI, 'all'))*(1-mmPPV)*(1-mmNPV));
mccj = sqrt(mjPPV*mean(HitsJSD, 'all')*(1-mean(FASJSD, 'all')*mjNPV))...
    -sqrt(mean(FASJSD, 'all')*(1-mean(HitsJSD, 'all'))*(1-mjPPV)*(1-mjNPV));

fprintf('Mean MOVI PPV = %.2f \n Mean JSD PPV = %.2f \n diff in PPV: p = %.2f, t= %.2f \n',mmPPV, mjPPV, p, stat.tstat)
fprintf('Mean MOVI NPV = %.2f \n Mean JSD NPV = %.2f \n diff in NPV: p = %.2f, t= %.2f \n',mmNPV, mjNPV, pn, statn.tstat)
fprintf('MK MOVI = %.2f, MK JSD = %.2f, \n', mkm, mkj)
fprintf('Accuracy MOVI = %.2f, Accuracy JSD = %.2f \n', accm, accj)
fprintf( 'MCC MOVI = %.2f, MCC JSD = %.2f \n', mccm, mccj)