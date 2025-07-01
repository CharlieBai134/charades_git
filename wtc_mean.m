%wtc mean across time and period scale

raw_path = uigetdir();
sub_list = dir(fullfile(raw_path,'*.mat'));

wtcMean{1,1} = 'SubID'; 
wtcMean{1,2} = 'OxyWTCmean';
wtcMean{1,3} = 'DxyWTCmean';

errorRcd{1,1} = 'SubID'; 
errorRcd{1,2} = 'Oxyerror';
errorRcd{1,3} = 'Dxyerror';

for sub = 1:length(sub_list)
    load(fullfile(raw_path,sub_list(sub).name));
    wtcMean{sub+1,1} = sub_list(sub).name(1:end-4);
    errorRcd{sub+1,1} = sub_list(sub).name(1:end-4);
    for sp = 1:2
        for cond = 1:9
            for ch = 1:22
                tmpfilter = ((Wtc_rs{2,sp+1}{1,cond}{1,ch}) <= 1 & ...
                    (Wtc_rs{2,sp+1}{1,cond}{1,ch} >= -1));
                % if wrong Rsq exists in a channel matrix, errorRcd{cond,ch} = 0, 
                errorRcd{sub+1,sp+1}{cond,ch} = floor(mean(mean(tmpfilter)));  
                %caculate Rsq means without wrong time-frequence
                wtcMean{sub+1,sp+1}{cond,ch} = ...
                    mean(mean(Wtc_rs{2,sp+1}{1,cond}{1,ch}(tmpfilter),'omitnan'),'omitnan');
            end
        end
    end
    subfeedback = ['------ sub:',num2str(sub),'completed------'];
    disp(subfeedback);
end