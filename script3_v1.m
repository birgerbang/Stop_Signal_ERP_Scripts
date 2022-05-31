[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab; %loads eeglab

DataDir = "Analyse"; %directory where raw data is stored
RawFiles = dir(fullfile(DataDir,'*.set')); %lists all set files
for i = 1:2:length(RawFiles)
    %Load raw files:
    disp("Now concatenating: " + RawFiles(i).name + ' and ' + RawFiles(i+1).name)
    EEG1 = pop_loadset('filename',RawFiles(i).name,'filepath','/Users/birgerbang/Desktop/PEPE/Analyse/');
    EEG2 = pop_loadset('filename',RawFiles(i+1).name,'filepath','/Users/birgerbang/Desktop/PEPE/Analyse/');
    %Concatenate files:
    EEG = pop_mergeset( EEG1, EEG2);
    %Extract successful go:
    EEG_EPOCH1 = pop_epoch( EEG, {  'go_signal_successful'  }, [-0.2         1.4], 'newname', 'go_signal_successful', 'epochinfo', 'yes');
    %remove baseline from epochs
    EEG_EPOCH1 = pop_rmbase( EEG_EPOCH1, [-200 0] ,[]);
    %Run ICA
    EEG_EPOCH1 = pop_runica(EEG_EPOCH1, 'icatype', 'runica', 'extended',1);
    %Save epoch set.
    fileName1 = strcat(RawFiles(i).name(1:end-5), 'go_successful');
    EEGSAVE = pop_saveset( EEG_EPOCH1, 'filename', fileName1,'filepath','/Users/birgerbang/Desktop/PEPE/GoEpochs/');
end