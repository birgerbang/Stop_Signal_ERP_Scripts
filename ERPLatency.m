%%% ERP latency detection %%%

participant = {};
condition = {};
group = {};
peak_latenciesN2 = {};
half_area_latenciesN2 = {};
peak_latenciesP3 = {};
half_area_latenciesP3 = {};

DataDir = "StopEpochs/"; %directory where epoched data is stored
RawFiles = dir(fullfile(DataDir,'*.daterp')); %lists all set files

samplesN2 = 75:125; %set window of interest for N2: 100 to 250 ms post stop signal
samplesP3 = 113:175; %window of onterest for P300: 250 to 500ms post stop signal
channelIdX = 32; % FCz = 32, Cz = 14
channelId = 'chan32';
sampling_rate = 250;
stimulus_onset = 50; %stop signal at 200ms into epoch

time_windowN2 = [100 250]; % use the  time window (for example)
time_windowP3 = [250 500]
 
for l = 1:length(RawFiles)
    fileName = RawFiles(l).name;
    %Load file:
    fileContent = load('-mat', strcat(DataDir, fileName));
    for i=1:length(fileContent.trialinfo)
        erp = fileContent.chan32(:,i);
      %%%%%%%%% N2 %%%%%%%%%%:
        samplesN2 = find(fileContent.times >= time_windowN2(1) & fileContent.times <= time_windowN2(2)); % the samples to test
        dataN2 = erp(samplesN2); % pull out the data for this channel and time window
        peak_latencyN2 = fileContent.times( samplesN2( find( dataN2==min(dataN2) )  ) );  % get the minimum latency in this window (max() can be replaced with min() for a_ > _negative peak)_


        adjustedN2 = dataN2-max(dataN2); %adjusted for negative going erp
        [~,indexN2] = min(abs(cumsum(adjustedN2)-sum(adjustedN2)/2)); %find the index tha best divides it into 50-percent area

        hal_area_latencyN2 = fileContent.times( samplesN2((indexN2)));
        %[~,latency_indexN2] = min(abs(cumsum(erp_adjustedN2)-sum(erp_adjustedN2)/2));
        peak_latenciesN2 = [peak_latenciesN2, peak_latencyN2]; %adding N2 latency
        half_area_latenciesN2 = [half_area_latenciesN2, hal_area_latencyN2];
        
        %%%%%%%%% P3 %%%%%%%%%%:
        samplesP3 = find(fileContent.times >= time_windowP3(1) & fileContent.times <= time_windowP3(2)); % the samples to test
        dataP3 = erp(samplesP3); % pull out the data for this channel and time window
        peak_latencyP3 = fileContent.times( samplesP3( find( dataP3==max(dataP3) )  ) );  % get the min latency in this window 


        adjustedP3 = dataP3-min(dataP3); %adjusted for positive going erp
        [~,indexP3] = min(abs(cumsum(adjustedP3)-sum(adjustedP3)/2)); %find the index tha best divides it into 50-percent area

        hal_area_latencyP3 = fileContent.times( samplesP3((indexP3)));
        %[~,latency_indexN2] = min(abs(cumsum(erp_adjustedN2)-sum(erp_adjustedN2)/2));
        peak_latenciesP3 = [peak_latenciesP3, peak_latencyP3]; %adding N2 latency
        half_area_latenciesP3 = [half_area_latenciesP3, hal_area_latencyP3];

        %%%%%%% Other variables %%%%%%%%%%
        participant = [participant, fileName(1:end-7)];
        condition = [condition, fileContent.trialinfo(i).condition];
        group = [group, fileContent.trialinfo(i).group];
    end
end
%%
dataTable = [peak_latenciesN2.', half_area_latenciesN2.',peak_latenciesP3.', half_area_latenciesP3.', participant.', condition.', group.']; %add data to table matrix
dataTable = [{'N2 peak', 'N2 half area', 'P3 peak', 'P3 half area','participant', 'condition', 'group'}; dataTable]; %add header
writecell(dataTable,'LatencyN3P3table.txt');

