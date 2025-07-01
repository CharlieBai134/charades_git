%每一个被试做一行，9*22列
%仅计算oxy
%使用带通过滤后的数据
%没有第45号被试，只有102行

load('wtcmeanBP.mat');
load('errorRcd.mat');
load('chan2ROI.mat');
%%
for i = 1:22
    for j = 1:9
        wtcSubCh_BP{1,(i-1)*9+j} = ['ch',num2str(i),'_cond',num2str(j)];
    end
end

for sub = 2:length(wtcMeanBP)
    tmpfilter = cell2mat(errorRcd{sub,2});
    tmpWTC = wtcMeanBP{sub,2};
    tmpWTC(tmpfilter ~= 1) = {NaN}; %delete bad channel from wtcMeanBP
    wtcSubCh_BP(sub,:) = tmpWTC(:)';
end
writecell(wtcSubCh_BP,'wtcSubCh_BP_noBadCh.xlsx');
%%
%ROI6是前额的12个通道的平均值
ch2roiCell = {[7,12,16],[9,13,18],[17,21,22],[3,4,8],[1,5,6,10,14,15,19],[7,12,16,9,13,18,17,21,22,3,4,8]};
for roi = 1:6
    %title
    for cond = 1:9
        wtcSubROI_BP{1,(roi-1)*9+cond} = ['roi',num2str(roi),'_cond',num2str(cond)];
        wtcSubROI_BP_includeNaN{1,(roi-1)*9+cond} = ['roi',num2str(roi),'_cond',num2str(cond)];
    end
    %mean of each roi
    ch = ch2roiCell{roi};
    for p = 1:length(ch)
        tmpwtc(:,:,p) = cell2mat(wtcSubCh_BP(2:103,(ch(p)-1)*9+1:(ch(p)-1)*9+9));
    end
    %平均，有缺失值则不计算
    wtcSubROI_BP(2:103,(roi-1)*9+1:(roi-1)*9+9) = num2cell(mean(tmpwtc,3));
    %平均，有缺失值则忽略缺失值继续计算
    wtcSubROI_BP_includeNaN(2:103,(roi-1)*9+1:(roi-1)*9+9) = num2cell(mean(tmpwtc,3,'omitnan'));
end

% for roi = 1:5
%     for RIC = 1:3
%         switch RIC
%             case 1
%                 wtcSubROI_RIC_BP{1,(roi-1)*3+RIC} = ['roi',num2str(roi),'_rest'];
%                 wtcSubROI_RIC_BP(2:103,(roi-1)*3+RIC) = wtcSubROI_BP(2:103,roi*9);
%             case 2
%                 wtcSubROI_RIC_BP{1,(roi-1)*3+RIC} = ['roi',num2str(roi),'_individual'];
%                 wtcSubROI_RIC_BP(2:103,(roi-1)*3+RIC) = wtcSubROI_BP(2:103,roi*9);
%             case 3
%                 RICname = 'cooparation';
%         end
%         wtcSubROI_RIC_BP{1,(roi-1)*3+RIC} = ['roi',num2str(roi),'_',RICname];
%         wtcSubROI_RIC_BP(2:103,(roi-1)*3+RIC) = mean();
%     end
% end
writecell(wtcSubROI_BP,'wtcSubROI_BP.xlsx');
writecell(wtcSubROI_BP_includeNaN,'wtcSubROI_BP_includeNaN.xlsx');