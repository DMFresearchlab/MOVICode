

signMOVI = zeros(size(pvalmovi));
cond = pvalmovi < 0.05 & tvalmovi > 0;
signMOVI = cond; 

signJSD = zeros(size(pvalJSD));
cond = pvalJSD < 0.05 & tvalmovi > 0;
signJSD = cond; 

v2 = varparam2(end:-1:1);

nobs = 100;
for i = 1:length(varparam1)
    for j = 1:length(varparam2)
        Index = [repmat("JSD",nobs,1); repmat("MV",nobs,1)];
        Hit = [squeeze(signJSD(:, i, j)); squeeze(signMOVI(:, i, j))];
        data = table(Index, Hit);
        modelspec = 'Hit ~ Index';
        mdl = fitglm(data,modelspec,'Distribution','binomial');
        tvals(i, j) = mdl.Coefficients.tStat(2);
        pvals(i, j) = mdl.Coefficients.pValue(2);
    end
end

pvals_z = 1-pvals;
% 
% figure;
% subplot(121)
% imagesc(varparam1, varparam2, tvals')
% set(gca, 'Ydir', 'normal')
% if PACstrx == 1
%     hold on
%     xline(0.45, 'linewidth', 2)
%     hold on
%     xline(0.7, 'linewidth', 2)
% end
% set(gca, 'YDir', 'normal')
% xlabel(xlab)
% ylabel(ylab)
% colormap(flipud(brewermap([], 'RdBu')))
% set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
% set(gcf, 'renderer', 'Painters')
% set(gcf, 'color', 'white');
% title('T-values Binomial test')
% caxis([-3, 3])
% colorbar()
% subplot(122)
% imagesc(varparam1, varparam2, pvals')
% colormap(flipud(brewermap([], 'RdBu')))
% set(gca, 'Ydir', 'normal')
% if PACstrx == 1
%     hold on
%     xline(0.45, 'linewidth', 2)
%     hold on
%     xline(0.7, 'linewidth', 2)
% end
% set(gca, 'YDir', 'normal')
% xlabel(xlab)
% ylabel(ylab)
% set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',14,'FontWeight','bold', 'LineWidth', 3);
% set(gcf, 'renderer', 'Painters')
% set(gcf, 'color', 'white');
% title('P-values Binomial test')
% caxis([0, 1])
% colorbar()