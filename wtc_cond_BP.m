%将wtcMeanBP中的数字排列为一个表格，每个被试的每个通道为单独一行
%删掉在errorRcd中记录的有坏点的通道
%仅计算oxy
%使用带通过滤后的数据
load('wtcmeanBP.mat');
load('errorRcd.mat');
load('chan2ROI.mat');

wtcCond_BP(1,1:15) ={'Subject','Channel','Sub_Ch','9','1','2','3', ...
    '4','5','6','7','8','ch_check','ROI','ROInum'};


for sub = 2:length(wtcMeanBP)
    %由于标题行导致的-2+2
    wtcCond_BP((sub-2)*22+2 : (sub-2)*22+22-1+2,1) = wtcMeanBP(sub,1);
    for ch = 1:22
        wtcCond_BP((sub-2)*22+2+ch-1,2) = num2cell(ch);
        wtcCond_BP((sub-2)*22+2+ch-1,3) = cellstr([wtcCond_BP{(sub-2)*22+2+ch-1,1},'_',num2str(ch)]);
        wtcCond_BP((sub-2)*22+2+ch-1,4) = wtcMeanBP{sub,2}(9,ch);
        for cond = 5:12
            wtcCond_BP{(sub-2)*22+2+ch-1,cond} = mean([wtcMeanBP{sub,2}{cond-4,ch}]);
        end
        wtcCond_BP{(sub-2)*22+2+ch-1,13} = floor(mean([errorRcd{sub,2}{:,ch}]));
        wtcCond_BP{(sub-2)*22+2+ch-1,14} = chan2ROI{ch+1,2};
        wtcCond_BP{(sub-2)*22+2+ch-1,15} = chan2ROI{ch+1,3};
    end
end

writecell(wtcCond_BP,'wtcCond_BP.xlsx');