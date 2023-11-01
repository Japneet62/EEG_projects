%% ------ HANDS ON. 6 ------ %% 
% Start EEGLAB 
% For 2 datasets: 
    % import a dataset
    % calculate standard deviation for each channel
    % store dataset in ALLEEG
    % apply a 1 Hz high-pass filter
    % calculate standard deviation for each channel
    % store dataset in ALLEEG    
% Plot the standard deviations as maps, into a single figure using subplot.
% Use the same scale for all maps.      ???

clear all; close all; clc;                                                  % clear workspace 

MAINPATH = 'C:\Users\japneet\Desktop\EEG\eegl';                 % set path vars 
PATHIN = [MAINPATH,'\rawdata']; 
PATHOUT = [MAINPATH,'\data\hands-on6']; 
CHANLOC = 'C:\\Users\\japneet\\Desktop\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'; 

cd(PATHIN);                                                                 % change the current dir to PATHIN to get the raw data    
% mkdir (PATHOUT);                                                          % create the pathout dir  

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;                                 % start eeglab 

data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};  % all datasets 

% LOAGING DATSETS, Getting channel location, naming, FILTERING, saving in ALLEEG. 
for i = 1:2
    % Unfiltered dataset 
    EEG = pop_loadbv(PATHIN,[data{i},'.vhdr'],[],[]);                       % load dataset 
    EEG.setname = [data{i},'_unfilt'];                                      % set name for unfiltered dataset 
    EEG = pop_chanedit(EEG,'lookup',CHANLOC);                               % add channel location information  
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);                       % store in ALLEEG
     
    % Filtered dataset     
    EEG = pop_eegfiltnew(EEG, 'hicutoff',1,'plotfreqz',1);
    EEG.setname = [data{i},'_filt'];                                        % set name of filtered data 
    [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG);                     % store in ALLEEG

    eeglab redraw;
end

stdv = []; 
% run a loop to calculate std and plot 4 subplots of std against chanloc in 1 fig  
for a = 1:4       % everything runs 4 times 
    stdv(a,:) = std(ALLEEG(a).data');                                         % calculate std of filtered and unfiltered data 
end

val = ceil(max(abs(stdv(:))));                                                

figure; 
for b = 1:4
    subplot(2,2,b); hold on;                                                % open a subplot, with 4  blocks 
    topoplot(stdv(b,:),ALLEEG(b).chanlocs,'maplimits',[-val,val]);          % create a topoplot for std values of chans agains the channel location, with the same scale for each graph  
    colorbar;
    title(ALLEEG(b).setname, 'interp', 'none');
end

cd(PATHOUT); 
saveas(setgcf,'Std_dev before and after filtering 2 datasets','png')

eeglab redraw; 


%% 10. Find and remove empty channels data from all the datasets 
cd(PATHIN); 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % start eeglab 
data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};  % all datasets 

for i = 1:length(data)                                                      % loop through all datasets 
    
    EEG = pop_loadbv(PATHIN, [data{i},'.vhdr'], [], []);                    % load datasets
    rem_chan = find(cellfun(@isempty,{EEG.chanlocs.X}));                    % identify empty elements indices 
    EEG = pop_select(EEG, 'nochannel', rem_chan);                           % remove emopty channels 
    EEG.setname = data{i};                                                  % setname 
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);                       % store in ALLEEG 
  %   EEG = pop_saveset( EEG, [data{i},'.set'],'filepath',PATHOUT);           % save dataset in PATHOUT 

end

eeglab redraw; 

