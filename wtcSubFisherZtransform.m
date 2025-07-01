%fisher z transform Sub Data
%% Sub_Channel
load('wtcSubCh_BP_noBadCh.mat');
wtcSubCh_BP_noBadCh_fisherZ = zeros(102,198);
for row = 2:103
    for col = 1:198
        r = wtcSubCh_BP{row,col};
        wtcSubCh_BP_noBadCh_fisherZ(row-1,col) = 0.5*log((1+r)/(1-r));
    end
end
%  writematrix(wtcSubCh_BP_noBadCh_fisherZ,'wtcSubCh_BP_noBadCh_fisherZ.xlsx')

%% Sub_ROI
ch2roiCell = {[7,12,16],[9,13,18],[17,21,22],[3,4,8],[1,5,6,10,14,15,19],...
    [7,12,16,9,13,18,17,21,22,3,4,8],[1,3:10,12:19,21:22]};
for roi = 1:length(ch2roiCell)
    %title
    for cond = 1:9
        wtcSubROI_BP_fisherZ{1,(roi-1)*9+cond} = ['roi',num2str(roi),'_cond',num2str(cond)];
        wtcSubROI_BP_fisherz_includeNaN{1,(roi-1)*9+cond} = ['roi',num2str(roi),'_cond',num2str(cond)];
    end
    %mean of each roi
    ch = ch2roiCell{roi};
    for p = 1:length(ch)
        tmpwtc(:,:,p) = wtcSubCh_BP_noBadCh_fisherZ(1:102,(ch(p)-1)*9+1:(ch(p)-1)*9+9);
    end
    %平均，有缺失值则不计算
    wtcSubROI_BP_fisherZ(2:103,(roi-1)*9+1:(roi-1)*9+9) = num2cell(mean(tmpwtc,3));
    %平均，有缺失值则忽略缺失值继续计算
    wtcSubROI_BP_fisherz_includeNaN(2:103,(roi-1)*9+1:(roi-1)*9+9) = num2cell(mean(tmpwtc,3,'omitnan'));
end

writecell(wtcSubROI_BP_fisherZ,'wtcSubROI_BP_fisherZ.xlsx');
writecell(wtcSubROI_BP_fisherz_includeNaN,'wtcSubROI_BP_fisherz_includeNaN_wholeB.xlsx');