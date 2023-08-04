BinDat1 = b1{end};
BinDat2 = b2{end};

Bindat1_avg = smoothbin(mean(BinDat1), 3);
Bindat2_avg = smoothbin(mean(BinDat2), 3);

figure;
subplot(131)
bar(Bindat1_avg)
title('Distribution A')
ylim([0.045 0.06])
xlim([1 18])
xlabel('Angle (rad)')
ylabel('Mean Amplitude')
subplot(132)
bar(Bindat2_avg)
ylim([0.045 0.06])
xlim([1 18])
title('Distribution B')
xlabel('Angle (rad)')
ylabel('Mean Amplitude')
subplot(133)
bar((Bindat1_avg-Bindat2_avg+2/18)/2)
ylim([0.045 0.06])
xlim([1 18])
title(sprintf('Alternate Distribution \n ((A-B)+2/nbins)/2'))
xlabel('Angle (rad)')
ylabel('Mean Amplitude')
ax = gca;
ax.FontSize = 16;
ax.FontWeight = 'bold';
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','bold', 'LineWidth', 3);
set(gcf, 'color', 'white');
set(gcf, 'renderer', 'Painters')

BinDat = BinDat1-BinDat2([1:50], :);
BinDat = (zscore(BinDat, [],  'all')+1)/2;
% 
% 
% 
% for i =1:size(BinDat1, 1)
%     BinDat1(i, :) = (zscore(BinDat1(i, :))+1)/2;
%     BinDat2(i, :) = (zscore(BinDat2(i, :))+1)/2;
% end
% 
% BinDat1_avg = mean(BinDat1);
% BinDat2_avg = mean(BinDat2);
% % BinDat = (BinDat1-BinDat2+2/18)/2;
BinDat = mean(BinDat);

% BinDat = (BinDat1_avg-BinDat2_avg+2/18)/2;

figure;set(gcf,'Position', [0 0 900 650])
config.color = [0 0.4 0.7];
polarplot_bin_pat(BinDat, config)
[thfill rhofill zufill] = polarfill_bin_pat(BinDat, config);




polarfill(gca, thfill, thfill, zufill, rhofill, config.color, 0.3)
set(gca, 'children', flipud(get(gca, 'children')))
set(gcf, 'renderer', 'Painters')
