%% quality check
%这里的质量检查是根据研究的数据目测后自定的规则，可能并不广泛适用
clear;clc;
raw_path = uigetdir(); % .../03preprocessing/
sub_list = dir(fullfile(raw_path,'*.mat'));

QC_allCh = ones(102, 44);


for sub = 1:102
    load(fullfile(raw_path,sub_list(sub).name));
    for ch = 1:44
        tmp = nirsdata.oxyData(:,ch);
        zeroRate(sub,ch) = sum(abs(tmp) < 1e-5)/length(tmp);
        nanRate = sum(isnan(tmp))/length(tmp);
        if (max(tmp) > 2) || (min(tmp) < -2) || ...
                (zeroRate(sub,ch) > 0.001) || (nanRate > 0.3)
            QC_allCh(sub,ch) = 0;
        end
    end
end
QC_PairCh = QC_allCh(:,1:22) .* QC_allCh(:,23:44);
%%
a = sum(floor(mean(QC_PairCh(:,[1,3:10,12:19,21:22]), 2))); 
% 得到答案71，即共有71人所有通道都通过上面的检验
%% 进行目测，删掉不符合的通道，得到usableCh.mat
%% 依据usableCh来删掉wtcSubCh_BP_noBadCh.mat中的坏通道
load('wtcSubCh_BP_noBadCh.mat');
load('2403\usableCh.mat');
wtcSubCh_BP_usableCh = wtcSubCh_BP;
for sub = 1:length(usableCh)
    for ch = 1:size(usableCh,2)
        chRange = (ch-1)*9+1:ch*9;
        if usableCh(sub,ch) == 0
           wtcSubCh_BP_usableCh(sub+1,chRange) = {NaN};
        end
    end
end
% fisher z transform
wtcSubCh_BP_usableCh_fisherZ = zeros(102,198);
for row = 2:103
    for col = 1:198
        r = wtcSubCh_BP_usableCh{row,col};
        wtcSubCh_BP_usableCh_fisherZ(row-1,col) = 0.5*log((1+r)/(1-r));
    end
end
%writematrix(wtcSubCh_BP_usableCh_fisherZ,'2403/wtcSubCh_BP_usableCh_fisherZ.xlsx')
%% Ch2ROI
ch2roiCell = {[7,12,16],[9,13,18],[17,21,22],[3,4,8],[1,5,6,10,14,15,19],...
    [7,12,16,9,13,18,17,21,22,3,4,8],[1,3:10,12:19,21:22]};
for roi = 1:length(ch2roiCell)
    %title
    for cond = 1:9
        wtcSubROI_BP_fisherz_includeNaN{1,(roi-1)*9+cond} = ['roi',num2str(roi),'_cond',num2str(cond)];
    end
    %mean of each roi
    ch = ch2roiCell{roi};
    for p = 1:length(ch)
        tmpwtc(:,:,p) = wtcSubCh_BP_usableCh_fisherZ(1:102,(ch(p)-1)*9+1:(ch(p)-1)*9+9);
    end
    %平均，有缺失值则忽略缺失值继续计算
    wtcSubROI_BP_fisherz_includeNaN(2:103,(roi-1)*9+1:(roi-1)*9+9) = num2cell(mean(tmpwtc,3,'omitnan'));
end
writecell(wtcSubROI_BP_fisherz_includeNaN,'2403/wtcSubROI_BP_usable_fisherz_includeNaN.xlsx');