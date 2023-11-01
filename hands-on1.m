%% ------ HANDS ON SESSION 1: load, plot --------

%% How to set the preferences for EEGLAB?
% 1. Codes always used in every script 
% 2. add path - code / setpath > select path > add with subfolders 
% 3. set current directory 
% 4. start eeglab - code / GUI 
% 5. load dataset (single, multiple together) - code / GUI
% 6. plot data - code / GUI
% 7. save dataset - code / GUI
% 8. update EEGLAB GUI - code 
%% 9. Plotting only 1 sec of the data - code ? not done 
% 10. Add channel locations 

%% How to set the preferences for EEGLAB?       CHECK AGAIN!!!!!!!!!!!!!!! 
% Preferences > 

%% ** CODE ALWAYS USED IN EVERY SCRIPT ** %%  
clear all; close all; clc;      % always the first line in the script 

% ADD PATH variables to go to different directories
MAINPATH = 'C:\Users\japneet\Desktop\EEG\eegl\';
PATHIN = [MAINPATH,'rawdata'];
PATHOUT = [MAINPATH,'data\looping_03'];
% mkdir PATHOUT

% Set the path to access the files needed 
cd(MAINPATH);





%% Load dataset 

% start eeglab
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% load dataset
EEG = pop_loadbv('C:\Users\japneet\Desktop\EEG\eegl\rawdata\', 'PP_2020_01.vhdr', [1 306215], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]);

    % we can also write it like this: 
    EEG = pop_loadbv(PATHIN, 'PP_2020_03.vhdr', [], []); % load eeg dataset



%% Code chunk always used in EEGLAB
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadbv(PATHIN, 'PP_2020_04.vhdr', [1 EEG.srate*60], []);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');
EEG = eeg_checkset( EEG );





%% PLOT DATA USING GUI 
% After loading data > GUI - Select data > plot > Channel data (scroll) 

%% PLOT DATA USING 'eegh' & CODING 

% start eeglab
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% load dataset
EEG = pop_loadbv(PATHIN, 'PP_2020_03.vhdr', [], []); % load eeg dataset

% Edit/save EEG dataset structure information: array f eeg dataset, "EEG" 
% matrix, index of the current EEG dataset in ALLEG,
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');


%% Plot only one sec of the data 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadbv(PATHIN, 'PP_2020_04.vhdr', [1 EEG.srate*60], []);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');
EEG = eeg_checkset( EEG );

pop_eegplot(EEG, 1, 1, 1);  % Plot data 

%% update the eeglab gui (Always use this code at the end of the script)
eeglab redraw;

