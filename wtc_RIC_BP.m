%根据wtc_mean计算在静息R、单独I和合作C三大状态下的wtc差异，每一个通道作为一行
%删掉在errorRcd中记录的有坏点的通道
%仅计算oxy
%使用带通过滤后的数据
load('wtcmeanBP.mat');
load('errorRcd.mat');

wtcRIC_BP(1,1:7) ={'Subject','Channel','Sub_Ch','restRsqmean','indivRsqmean','cooperRsqmean','ch_check'};
for i = 1:9
    wtcRIC_BP{1,i+7} = ['cond',num2str(i)];
end

for sub = 2:length(wtcMeanBP)
    %由于标题行导致的-2+2
    wtcRIC_BP((sub-2)*22+2 : (sub-2)*22+22-1+2,1) = wtcMeanBP(sub,1);
    for ch = 1:22
        wtcRIC_BP((sub-2)*22+2+ch-1,2) = num2cell(ch);
        wtcRIC_BP((sub-2)*22+2+ch-1,3) = cellstr([wtcRIC_BP{(sub-2)*22+2+ch-1,1},'_',num2str(ch)]);
        wtcRIC_BP((sub-2)*22+2+ch-1,4) = wtcMeanBP{sub,2}(9,ch);
        wtcRIC_BP{(sub-2)*22+2+ch-1,5} = mean([wtcMeanBP{sub,2}{[1 2 5 6],ch}]);
        wtcRIC_BP{(sub-2)*22+2+ch-1,6} = mean([wtcMeanBP{sub,2}{[3 4 7 8],ch}]);
        wtcRIC_BP{(sub-2)*22+2+ch-1,7} = floor(mean([errorRcd{sub,2}{:,ch}]));
        wtcRIC_BP((sub-2)*22+2+ch-1,8:16) = wtcMeanBP{sub,2}(1:9,ch)';
    end
end

writecell(wtcRIC_BP,'wtcCond_CH_BP.xlsx');