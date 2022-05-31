%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         To count relevant stop trials according to difficulty criteria
%         as defined in rateEvents.m.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hard_accuracies = [];
easy_accuracies = [];
SSD_easier = [];
SSD_harder = [];

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab; %loads eeglab

DataDir = "Prep1"; %directory where raw data is stored
RawFiles = dir(fullfile(DataDir,'*.set')); %lists all set files
for i = 1:length(RawFiles)
    easy_successful = 0;
    easy_unsuccessful = 0;
    hard_successful = 0;
    hard_unsuccessful = 0;
    fileName = RawFiles(i).name;
    %Load raw files:
    EEG = pop_loadset('filename',RawFiles(i).name,'filepath','/Users/birgerbang/Desktop/PEPE/Prep1/');
    rateEvents; %adds count of various categories defined above
    easy_accuracy = easy_successful/(easy_unsuccessful+easy_successful);
    hard_accuracy = hard_successful/(hard_unsuccessful+hard_successful);

    easy_accuracies = [easy_accuracies, easy_accuracy];
    hard_accuracies = [hard_accuracies, hard_accuracy];

    SSD_easier = [SSD_easier, SSD_easy];
    SSD_harder = [SSD_harder, SSD_hard];
end
%%
easier_accuracies = [];
harder_accuracies = [];
for i = 1:2:length(easy_accuracies)
    easier_accuracies = [easier_accuracies, (easy_accuracies(i)+easy_accuracies(i+1))/2];
    harder_accuracies = [harder_accuracies, (hard_accuracies(i)+hard_accuracies(i+1))/2];
end
%%
dlmwrite('easier_accuracies.txt',easier_accuracies(:),'newline','pc');
dlmwrite('harder_accuracies.txt',harder_accuracies(:),'newline','pc');
dlmwrite('SSD_easier.txt', SSD_easier(:), 'newline', 'pc');
dlmwrite('SSD_harder.txt', SSD_harder(:), 'newline', 'pc');