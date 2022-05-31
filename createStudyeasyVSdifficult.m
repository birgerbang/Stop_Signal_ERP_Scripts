% EEGLAB scipt for making 2-level study
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
DataDir = "StopEpochs"; %directory where raw data is stored
RawFiles = dir(fullfile(DataDir,'*.set')); %lists all set files
%%
datsets = cell(length(RawFiles), 1); %for storing datasetnames
subjs = cell(length(RawFiles)/4, 1); %for storing subjetc number
condname = cell(length(datsets), 1); %for storing conditions names

for i = 1:length(RawFiles)
    datsets{i} = strcat('/Users/birgerbang/Desktop/PEPE/StopEpochs/', RawFiles(i).name);
end

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

%%% Open eeglab:
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; % open eeglab
% Set memory options:
pop_editoptions( 'option_storedisk', 1, 'option_savematlab', 1,'option_computeica', 0, 'option_rememberfolder', 1); % saves a file 'eeg_options.m' to your current working directory
%Initialize STUDY:
STUDY = []; CURRENTSTUDY = 0; ALLEEG=[]; EEG=[]; CURRENTSET=[]; 

for nx= 1:length(datsets)
    if exist('gdcomps')
        [STUDY, ALLEEG] = std_editset( STUDY, ALLEEG,...
        'commands',{ 'index',nx, 'load', datsets{nx} ,...
        'subject', subjs{nx},'condition',condname{nx},...
        'comps', gdcomps{nx}} );
    else
        [STUDY, ALLEEG] = std_editset( STUDY, ALLEEG,...
            'commands',{ 'index',nx, 'load', datsets{nx} ,...
            'subject', subjs{nx},'condition',condname{nx},...
            'dipselect',.15} );
    end
end

%% Name the STUDY
[STUDY ALLEEG] = std_editset( STUDY, ALLEEG,  'name',...
    'Synonyms', 'task', 'Word Recog.');

% update the GUI:
CURRENTSTUDY = 1; EEG = ALLEEG;CURRENTSET = [1:length(EEG)];
[STUDY, ALLEEG] = std_checkset(STUDY, ALLEEG);
eeglab redraw

% SAVE THE STUDY
%%%%%%%%%%%%% Variables:
savename= 'diffEasy.study';
pathname= '/Users/birgerbang/Desktop/PEPE/Study/';

[STUDY EEG] = pop_savestudy( STUDY, EEG,'filename', savename,...
    'filepath', pathname);

