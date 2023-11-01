%% Calculate the standard devistion
% std gives us the std of each channel

clear all; close all; clc;      % always the first line in the script 

% ADD PATH variables to go to different directories
MAINPATH = 'C:\Users\Tammaso\OneDrive\Desktop\New Folder\EEG\eegl';
PATHIN = [MAINPATH,'/rawdata/rawdata'];
PATHOUT = [MAINPATH,'/results/'];

% Set the path to access the files needed 
cd(MAINPATH);

SUB = {'PP_2020_00','PP_2020_01'};          % Var with dataset names

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;    %start eeglab

for s=1:length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB{s} '.vhdr'], [], []); % load eeg dataset
    EEG.setname=SUB(s); 
    
    % Calculate std for each channel 
    
    [ALLEEG EEG CURRENTDATASET] = eeg_store(ALLEEG, EEG);
end 

eeglab redraw;

