% 数据条件mark点文件制作

raw_path = uigetdir();

sub_list = dir(fullfile(raw_path,'*.mat'));

% 定义design_inf的标头
design_inf{1,1} = 'SubID\ConditionName';
design_inf(1,2:10) = {'Condition1','Condition2','Condition3','Condition4','Condition5','Condition6','Condition7','Condition8','Condition9'};

mark_onset{1,1} = 'SubID';
mark_onset{1,2} = 'Cond_Onset1-9';
mark_onset{1,3} = 'Max_Onset';
mark_onset{1,4} = 'Length_TS';
mark_onset{1,5} = 'RZ_TS';

save_path = uigetdir();


for sub = 1:length(sub_list)
    load(fullfile(raw_path,sub_list(sub).name));
    
    design_inf{sub+1,1} = sub_list(sub).name(1:end-4);
    mark_onset{sub+1,1} = sub_list(sub).name(1:end-4);

    for ii = 1:9
        design_inf{sub+1,ii+1}(1,1) = find(nirsdata.vector_onset==ii);
        design_inf{sub+1,ii+1}(1,2) = 1200;

        mark_onset{sub+1,2}(1,ii) = find(nirsdata.vector_onset==ii);
    end
    
    mark_onset{sub+1,3} = max(mark_onset{sub+1,2});
    mark_onset{sub+1,4} = length(nirsdata.vector_onset);
    mark_onset{sub+1,5} = mark_onset{sub+1,4}-mark_onset{sub+1,3}-1200;


    % resave
% 
%     nirsdata.oxyData = nirsdata.oxyData(1:mark_onset{sub+1,3}+1220,:);
%     nirsdata.dxyData = nirsdata.dxyData(1:mark_onset{sub+1,3}+1220,:);
%     nirsdata.totalData = nirsdata.totalData(1:mark_onset{sub+1,3}+1220,:);
%     nirsdata.vector_onset = nirsdata.vector_onset(1:mark_onset{sub+1,3}+1220,1);
%     
%     save(fullfile(save_path,sub_list(sub).name),'nirsdata');

end

