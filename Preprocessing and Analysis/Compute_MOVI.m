for trl = 1:size(amp1, 1)
    binned1(trl, :) = BinVec(phase1(trl, :), amp1(trl, :), nbins);
end
%normalize
for trl= 1:size(amp1, 1)
    binned1(trl, :) = binned1(trl, :)/sum(binned1(trl, :));
    binned1(trl, :) = smoothbin(binned1(trl, :), 3);
end

for trl = 1:size(amp2, 1)
    binned2(trl, :) = BinVec(phase2(trl, :), amp2(trl, :), nbins);
end
%normalize
for trl= 1:size(amp2, 1)
    binned2(trl, :) = binned2(trl, :)/sum(binned2(trl, :));
    binned2(trl, :) = smoothbin(binned2(trl, :), 3);
end
binned1_exp = binned1;
binned2_exp = binned2;
binavg1 = mean(binned1, 1);
binavg2 = mean(binned2, 1);

altBin = ((binavg1-binavg2)+ (2/nbins))/2; %MOVI
altBin = altBin./sum(altBin);
altBin_m(:, 1, :) = altBin;
config.output = 'MVL';

MOVI = Compute_MVL(altBin_m, config);
KLD = ComputeKLD(binavg1, binavg2);
JSD = ComputeJSD(binavg1, binavg2);


% 
% figure;
% subplot(221)
% bar(binavg1)
% ylim([0.05 0.06])
% subplot(222)
% bar(binavg2)
% ylim([0.05 0.06])
% subplot(2, 2, [3 4])
% bar(altBin)
% ylim([0.05 0.06])

%% surrogates
for n_iter = 1:1000
%     showprogress(n_iter, 1000)
    
    ran1 = randperm(size(amp1, 1));
    ran2 = randperm(size(amp2, 1));
    
    
    for trl = 1:size(amp1, 1)
        binned1(trl, :) = BinVec(phase1(trl, :), amp1(ran1(trl), :), nbins);
    end
    %normalize
    for trl= 1:size(amp1, 1)
        binned1(trl, :) = binned1(trl, :)/sum(binned1(trl, :));
    end
    
    for trl = 1:size(amp2, 1)
        binned2(trl, :) = BinVec(phase2(trl, :), amp2(ran2(trl), :), nbins);
    end
    %normalize
    for trl= 1:size(amp2, 1)
        binned2(trl, :) = binned2(trl, :)/sum(binned2(trl, :));
    end
    
    binavg1 = mean(binned1, 1);
    binavg2 = mean(binned2, 1);
    
    altBin = ((binavg1-binavg2)+ (2/nbins))/2; %MOVI
    altBin = altBin./sum(altBin);
    altBin_m(:, 1, :) = altBin;
    config.output = 'MVL';
    
    MOVI_s(n_iter) = Compute_MVL(altBin_m, config);
    KLD_s(n_iter) = ComputeKLD(binavg1, binavg2);
    JSD_s(n_iter) = ComputeJSD(binavg1, binavg2);
end

% 
% figure;
% histogram(MOVI_s,50);
% hold on
% plot([MOVI MOVI],get(gca,'ylim')/2,'m-p','linewi',4,'markersize',16);
% legend({'histogram of permuted PAC values';'observed PAC value'})
% xlabel('MVL of MOVI distribution')
% ylabel('Count')
% ylim([0 80])
% xmin = (min(MOVI_s, [], 'all')-min(MOVI_s, [], 'all')/5);
% maxval = max([max(MOVI) max(MOVI_s, [], 'all')]);
% xmax= (maxval+min(MOVI_s, [], 'all')/5);
% xlim([xmin xmax])
% set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
% set(gcf, 'renderer', 'Painters')
% title('MOVI')
% 
% 
% figure;
% histogram(KLD_s,50);
% hold on
% plot([KLD KLD],get(gca,'ylim')/2,'m-p','linewi',4,'markersize',16);
% legend({'histogram of permuted PAC values';'observed PAC value'})
% xlabel('MVL of MOVI distribution')
% ylabel('Count')
% ylim([0 80])
% xmin = (min(KLD_s, [], 'all')-min(KLD_s, [], 'all')/5);
% maxval = max([max(KLD) max(KLD_s, [], 'all')]);
% xmax= (maxval+min(KLD_s, [], 'all')/5);
% xlim([xmin xmax])
% set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
% set(gcf, 'renderer', 'Painters')
% title('DKL')
% 
% figure;
% histogram(JSD_s,50);
% hold on
% plot([JSD JSD],get(gca,'ylim')/2,'m-p','linewi',4,'markersize',16);
% legend({'histogram of permuted PAC values';'observed PAC value'})
% xlabel('MVL of MOVI distribution')
% ylabel('Count')
% ylim([0 80])
% xmin = (min(JSD_s, [], 'all')-min(JSD_s, [], 'all')/5);
% maxval = max([max(JSD) max(JSD_s, [], 'all')]);
% xmax= (maxval+min(JSD_s, [], 'all')/5);
% xlim([xmin xmax])
% set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
% set(gcf, 'renderer', 'Painters')
% title('JSD')