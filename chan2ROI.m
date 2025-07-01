chan2ROI{1,1} = 'channel';
chan2ROI{1,2} = 'ROI';
chan2ROI{1,3} = 'probe';

rSTS = [1,5,6,10,14,15,19];
riPFC = [17,21,22];
rdlPFC = [7,12,16];
rsPFC = [3,8,4];
rfpPFC = [9,13,18];
non = [2,11,20];

chan2ROI([rSTS+1,rSTS+23],2) = {'rSTS'};
chan2ROI([riPFC+1,riPFC+23],2) = {'riPFC'};
chan2ROI([rdlPFC+1,rdlPFC+23],2) = {'rdlPFC'};
chan2ROI([rsPFC+1,rsPFC+23],2) = {'rsPFC'};
chan2ROI([rfpPFC+1,rfpPFC+23],2) = {'rfpPFC'};
chan2ROI([non+1,non+23],2) = {'non'};