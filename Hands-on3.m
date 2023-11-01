%% ----------- HANDS-ON SESSION 3 ------------ 
% 1. start eeglab 
% 2. for several datasets 
    % import dataset 
    % add channel locations 
    % extract the length of the data (EEG.pnts) in a variable
    % save your dataset 
% plot the results stored in your variable 
% save the plot as a figure 

clear all; close all; clc; 

MAINPATH = 'C:\Users\japneet\Desktop\EEG\eegl';                 % save vars for data paths 
PATHIN = [MAINPATH,'\rawdata']; 
PATHOUT = [MAINPATH, '\data\hand-on3']; 
CHANS = 'C:\\Users\\japneet\\Desktop\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'

data = {'PP_2020_00.vhdr','PP_2020_01.vhdr','PP_2020_02.vhdr',...           % Variable with the dataset names to be workeed on later 
    'PP_2020_03.vhdr','PP_2020_04.vhdr'};                                   % cell array 

pnts = [];                                                                  % empty var pnts to store dataset langths 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % Start eeglab 

for s=1:length(data)                                                        % loop runs till the length of 'data'
    
    EEG = pop_loadbv(PATHIN, data{s},[], []);                               % load the dataset at the position 's' from the 'data' cell array      
    EEG = pop_chanedit(EEG, 'lookup',CHANS);                                % add channel location information 
    EEG = eeg_checkset( EEG );                                              % check if the data matches the required fields 
    EEG = pop_saveset( EEG, 'filename',[data{s},'.set'],'filepath',PATHOUT);% save datasets 
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);                      % store the updated info in the STRUCT 'EEG'
    pnts(s) = EEG.pnts;                                                     % get the dataset length for each dataset 
    eeglab redraw;                                                          % update eeglab to see the processing 
end
cd(PATHOUT);

figure;                                                                     % create a plot showing the dataset lengths  
plot(pnts); 
title('No. of samples per channel in each dataset/Dataset lengths'); 
saveas(gca, 'length_datasets', 'png');                                      % save the plot in 'PATHOUT' directory 

eeglab redraw;                                                              % Update eeglab just for convenience 
