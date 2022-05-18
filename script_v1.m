[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab; %loads eeglab

DataDir = "Data/RawDataEEG"; %directory where raw data is stored
RawFiles = dir(fullfile(DataDir,'*.vhdr')); %lists all vhdr files
for i = 1:length(RawFiles)
  baseFileName = RawFiles(i).name;
  fullFileName = fullfile(DataDir, baseFileName);
  disp("Now loading: " + fullFileName)
  %Load raw files:
  EEG = pop_loadbv(DataDir, baseFileName);
  %Downsample to 250Hz:
  EEG = pop_resample(EEG, 250);
  %High-pass filter at 1Hz:
  EEG = pop_eegfiltnew(EEG, 'locutoff',1);
  %Load channel positions:
  EEG=pop_chanedit(EEG, 'lookup','/Users/birgerbang/Documents/MATLAB/eeglab2022.0/plugins/dipfit/standard_BEM/elec/standard_1005.elc');
  %Save current EEG for use in re-referencing
  originalEEG = EEG;
  %Delete bad channels:
  %EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion','off','WindowCriterion','off','BurstRejection','off','Distance','Euclidian');
  %RUN ICA
  %EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
  %Interpolate channels:
  %EEG = eeg_checkset( EEG );
  %EEG = pop_interp(EEG, originalEEG.chanlocs, 'spherical');
  %Re-reference scalp data using earlobe electrodes as references:
  EEG = pop_reref( EEG, [30 31] ,'exclude',[32 33] );
  %Re-name the the events as to match the different conditions
  renameEvents
  %Save dataset:
  if strcmp(baseFileName, 'PEPE_11_1.vhdr') %file 1 should be renamed "SST_11_1":
      EEG = pop_saveset( EEG, 'filename','SST_11_1.set','filepath','/Users/birgerbang/Desktop/PEPE/Analyse/');
  else
      EEG = pop_saveset( EEG, 'filename',baseFileName(1:end-5),'filepath','/Users/birgerbang/Desktop/PEPE/Analyse/');

  end
  [ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end

%New:
