%wtc 
raw_path = uigetdir();
sub_list = dir(fullfile(raw_path,'*.mat'));
out_path = uigetdir();
load('mark_onset.mat');

sg_type  = ["oxyData","dxyData"]; %计算含氧与脱氧的数据

for sub = 94:103 %遍历所有被试
    load(fullfile(raw_path,sub_list(sub).name));
    filename = [out_path,'\wtc',sub_list(sub).name];
    Wtc_rs{1,1} = 'SubID';
    Wtc_rs{1,2} = 'OxyWTC';
    Wtc_rs{1,3} = 'DxyWTC';
    Wtc_rs{2,1} = sub_list(sub).name(1:end-4);
    for sp = 1:2 %含氧+脱氧
        for cond = 1:9 %9个block
            for ch = [1,3:10,12:19,21:22] %每个通道
                block_onset = mark_onset{sub+1,2}(cond);
                eval(['ts1 = nirsdata.',sg_type{sp},'(block_onset:block_onset+1200-1,ch);']);
                eval(['ts2 = nirsdata.',sg_type{sp},'(block_onset:block_onset+1200-1,ch+22);']);
%                 ts1 = nirsdata.oxyData(block_onset:block_onset+1200-1,ch);
%                 ts2 = nirsdata.oxyData(block_onset:block_onset+1200-1,ch+22);
                [Rsq,period,scale,coi] = wtc_bcl(ts1,ts2,'mcc',0); %计算WTC矩阵Rsq，这边使用的是修改过的wtc_bcl函数，也可以直接只用MATLAB自带的wcoherence函数，详情请doc
                Wtc_rs{2,sp+1}{1,cond}{1,ch} = Rsq; %数据写入
                chfeedback = ['sub: ', num2str(sub),' --- cond: ',num2str(cond),' --- ch: ',num2str(ch)];
                disp(chfeedback); %一个监控数据处理进程的小东西
            end
        end
    end
    save(filename,'Wtc_rs');
    clear Wtc_rs
    subfeedback = ['------ sub:',num2str(sub),'completed------'];
    disp(subfeedback);
end
