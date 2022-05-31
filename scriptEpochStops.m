[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab; %loads eeglab

DataDir = "Prep2"; %directory where raw data is stored
RawFiles = dir(fullfile(DataDir,'*.set')); %lists all set files
for i = 1:2:length(RawFiles)
    %Load raw files:
    disp("Now concatenating: " + RawFiles(i).name + ' and ' + RawFiles(i+1).name)
    EEG1 = pop_loadset('filename',RawFiles(i).name,'filepath','/Users/birgerbang/Desktop/PEPE/Prep2/');
    EEG2 = pop_loadset('filename',RawFiles(i+1).name,'filepath','/Users/birgerbang/Desktop/PEPE/Prep2/');
    %Concatenate files:
    EEG = pop_mergeset( EEG1, EEG2);
    %Extract unsuccessful stops easy%%%%%%%%:
    EEG_EPOCH1 = pop_epoch( EEG, {  'stop_signal_unsuccessful_easy'  }, [-0.2         0.8], 'newname', 'usuccessful_stops_easy', 'epochinfo', 'yes');
    %remove baseline from epochs
    EEG_EPOCH1 = pop_rmbase( EEG_EPOCH1, [-200 0] ,[]);
    %Run ICA
    EEG_EPOCH1 = pop_runica(EEG_EPOCH1, 'icatype', 'runica', 'extended',1);
    %Save epoch set.
    fileName1 = strcat(RawFiles(i).name(1:end-5), 'unsuccessful_stops_easy');
    EEGSAVE = pop_saveset( EEG_EPOCH1, 'filename', fileName1,'filepath','/Users/birgerbang/Desktop/PEPE/StopEpochs/');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Extract unsuccessful stops difficult:
    EEG_EPOCH1_2 = pop_epoch( EEG, {  'stop_signal_unsuccessful_difficult'  }, [-0.2         0.8], 'newname', 'usuccessful_stops_difficult', 'epochinfo', 'yes');
    %remove baseline from epochs
    EEG_EPOCH1_2 = pop_rmbase( EEG_EPOCH1_2, [-200 0] ,[]);
    %Run ICA
    EEG_EPOCH1_2 = pop_runica(EEG_EPOCH1_2, 'icatype', 'runica', 'extended',1);
    %Save epoch set.
    fileName2 = strcat(RawFiles(i).name(1:end-5), 'unsuccessful_stops_difficult');
    EEGSAVE = pop_saveset( EEG_EPOCH1_2, 'filename', fileName2,'filepath','/Users/birgerbang/Desktop/PEPE/StopEpochs/');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Extract successful stops easy:
    EEG_EPOCH2 = pop_epoch( EEG, {  'stop_signal_successful_easy'  }, [-0.2         0.8], 'newname', 'successful_stops_easy', 'epochinfo', 'yes');
    %remove baseline from epochs
    EEG_EPOCH2 = pop_rmbase( EEG_EPOCH2, [-200 0] ,[]);
    %Run ICA
    EEG_EPOCH2 = pop_runica(EEG_EPOCH2, 'icatype', 'runica', 'extended',1);
    %Save epoch set.
    fileName3 = strcat(RawFiles(i).name(1:end-5), 'successful_stops_easy');
    EEGSAVE = pop_saveset( EEG_EPOCH2, 'filename',fileName3,'filepath','/Users/birgerbang/Desktop/PEPE/StopEpochs/');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Extract successful stops difficult:
    EEG_EPOCH2_2 = pop_epoch( EEG, {  'stop_signal_successful_difficult'  }, [-0.2         0.8], 'newname', 'successful_stops_difficult', 'epochinfo', 'yes');
    %remove baseline from epochs
    EEG_EPOCH2_2 = pop_rmbase( EEG_EPOCH2_2, [-200 0] ,[]);
    %Run ICA
    EEG_EPOCH2_2 = pop_runica(EEG_EPOCH2_2, 'icatype', 'runica', 'extended',1);
    %Save epoch set.
    fileName4 = strcat(RawFiles(i).name(1:end-5), 'successful_stops_difficult');
    EEGSAVE = pop_saveset( EEG_EPOCH2_2, 'filename',fileName4,'filepath','/Users/birgerbang/Desktop/PEPE/StopEpochs/');
end