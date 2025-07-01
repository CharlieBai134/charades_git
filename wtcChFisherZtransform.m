%fisher z transform Ch Data
load('wtcRICCh_BP.mat');
wtcCh_BP_fisherZ(1,1:16) = wtcRIC_BP(1,1:16);
wtcCh_BP_fisherZ(1:length(wtcRIC_BP),[1:3,7]) = wtcRIC_BP(:,[1:3,7]);
for row = 2:length(wtcRIC_BP)
    for col = [4:6,8:16]
        r = wtcRIC_BP{row,col};
        wtcCh_BP_fisherZ{row,col} = 0.5*log((1+r)/(1-r));
    end
end
writecell(wtcCh_BP_fisherZ,'wtc011Ch_BP_fisherZ.xlsx')