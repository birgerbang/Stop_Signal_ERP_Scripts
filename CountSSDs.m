SSDs = {}
participant = {}
success = {}
easy = {}
nGoBefore = {}

SSDold = 0;
nGo = 0;
DataDir = "Prep1"; %directory where raw data is stored
RawFiles = dir(fullfile(DataDir,'*.set')); %lists all set files
for l = 1:length(RawFiles)
    fileName = RawFiles(l).name;
    %Load raw files:
    EEG = pop_loadset('filename',fileName,'filepath','/Users/birgerbang/Desktop/PEPE/Prep1/');
    for i = 1:numel(EEG.event)
        if strcmp(EEG.event(i).type, 'go_stop_signal_unsuccessful')
            if strcmp(EEG.event(i+1).type, 'stop_signal_unsuccessful')
                SSD = (EEG.event(i+1).latency-1)/EEG.srate - (EEG.event(i).latency-1)/EEG.srate;
                success = [success, 0];
            else
                disp("Something funny happend...")
            end
            SSDs = [SSDs, SSD];
            participant = [participant, fileName(5:end-6)];
            nGoBefore = [nGoBefore, nGo];
            if SSD < SSDold
                easy = [easy, 1];
            else
                easy = [easy, 0];
            end
            nGo = 0;
        elseif strcmp(EEG.event(i).type, 'go_stop_signal_successful')
            if strcmp(EEG.event(i+1).type, 'stop_signal_successful')
                SSD = (EEG.event(i+1).latency-1)/EEG.srate - (EEG.event(i).latency-1)/EEG.srate;
                success = [success, 1];
            else
                disp("Something funny happend...")
            end
            SSDs = [SSDs, SSD];
            participant = [participant, fileName(5:end-6)];
            nGoBefore = [nGoBefore, nGo];
            if SSD < SSDold
                easy = [easy, 1];
            else
                easy = [easy, 0];
            end
        end
        SSDold = SSD;
        if strncmp(EEG.event(i).type, 'go_signal', 8)
            nGo = nGo +1;
        end
        if strncmp(EEG.event(i).type, 'go_stop', 6)
            nGo = 0;
        end
    end
end
%%
participant = strip(participant, '_');
dataTable = [SSDs.', participant.', success.', easy.', nGoBefore.'];
dataTable = [{'SSD', 'ID', 'success', 'easy', 'nGoBefore'}; dataTable];
writecell(dataTable,'SSDtable.txt');