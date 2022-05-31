
[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab; %loads eeglab

DataDir = "StopEpochs"; %directory where raw data is stored
RawFiles = dir(fullfile(DataDir,'*.set')); %lists all set files
%%
datsets = cell(1, length(RawFiles)); %for storing datasetnames
subjs = cell(1, length(RawFiles)/4); %for storing subjetc number
condname = cell(1, length(datsets)); %for storing conditions names

l = 1;
for j = 1:4:length(RawFiles)
    subjs{j} = string(l);
    subjs{j+1} = string(l);
    subjs{j+2} = string(l);
    subjs{j+3} = string(l);

    condname{j} = "unsuccessful_difficult";
    condname{j+1} = "unsuccessful_easy";
    condname{j+2} = "successful_easy";
    condname{j+3} = "successful_difficult";

    l = l+1;
end

%%

f = 1;
for i = 1:length(RawFiles)
    fileName = RawFiles(i).name;
    %Load raw files:
    EEG = pop_loadset('filename',fileName,'filepath','/Users/birgerbang/Desktop/PEPE/StopEpochs/');
    EEG.session = 1;
    if mod(i,4) == 0
        EEG.group = 'easy';
        EEG.condition = 'unsuccessful';
        EEG.subject = num2str(f);
        f = f+1;
    elseif mod(i,4) == 1
        EEG.group = 'difficult';
        EEG.condition = 'successful';
        EEG.subject = num2str(f);
    elseif mod(i,4) == 2
        EEG.group = 'easy';
        EEG.condition = 'successful';
        EEG.subject = num2str(f);
    elseif mod(i,4) == 3
        EEG.group = 'difficult';
        EEG.condition = 'unsuccessful';
        EEG.subject = num2str(f);
    else
        disp('NB: something went wrong!')
    end
    if str2num(EEG.subject)<10
        EEG.subject = strcat('0', EEG.subject)
    end
    EEG = pop_saveset(EEG, 'filename',fileName,'filepath','/Users/birgerbang/Desktop/PEPE/StopEpochs/');
end