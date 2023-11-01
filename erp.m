
clear all; close all; clc;      % always the first line in the script 

%% Task 9: 
% 1. Use the datasets creates for the target condition as created in hands 
%    on session 8. 
% 2. Explore the different ways of plotting ERP using GUI
% 3. Create a ERP yourself by averaging EEG.data over the 3rd dimension. 
% 4. As an estimate of signal strength across all channels, calculate for 
%    each frame the standard deviation of the ERP. Plot the resulting GFP, 
%    maybe as an overlay to all channel ERPs
% 5. Find the peak latency of the GFP and plot the ERP map

% ADD PATH variables to go to different directories
MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl\';
PATHIN = [MAINPATH,'rawdata'];
PATHOUT = [MAINPATH,'data\erp_09'];

% Set the path to access the files needed 
cd(MAINPATH);
mkdir(PATHOUT); 


SUB={'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};     % Create a list with all subject file names 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % Start eeglab 
    
for s=1:length(SUB)                                                         % Run a loop through all the eeg files 
    EEG = pop_loadbv(PATHIN, [SUB{s} '.vhdr'], [], []);                     % load eeg dataset
    EEG.setname=SUB(s);                                                     % Set filenames 
    EEG=pop_chanedit(EEG, 'lookup',[MAINPATH,...                            % Add channel location information 
        '\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc']);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
    
    EEG = pop_eegfiltnew(EEG, 'locutoff',30,'hicutoff',0.3,'plotfreqz',1);  % Apply 0.3 hz high pass filter and 30 hz low pass filter 

    
    EEG = pop_epoch( EEG, {  'S  1'  'S  2'  }, [-1  2], 'newname',...      % Epoch the data with S1 and S2 events selected 
    'preprocessed epochs', 'epochinfo', 'yes');
    EEG = pop_rmbase( EEG, [-200 0] ,[]);                                   % Remove baseline from -200 to 0 ms. 

    eeglab redraw;                                                          % Update eeglab gui

    
end








