[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab; %loads eeglab
DataDir = "Epochs"; %directory where raw data is stored
RawFiles = dir(fullfile(DataDir,'*.set')); %lists all set files
for i = 1:length(RawFiles)
    fileName2 = strcat(RawFiles(i).name, 'pruned');
    EEG1 = pop_loadset('filename',RawFiles(i).name,'filepath','/Users/birgerbang/Desktop/PEPE/Epochs/');
    EEG1 = pop_subcomp( EEG1, [3  13], 0); %remove eyeblinks
    EEG1 = pop_rmbase( EEG1, [-200 0] ,[]); %recalculate baseline

    EEGSAVE = pop_saveset( EEG1, 'filename',fileName2,'filepath','/Users/birgerbang/Desktop/PEPE/Pruned/');

end
