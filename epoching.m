%% EPOCHING 
clear all; close all; clc; 

MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl\';                % Setting up path variables 
PATHIN = [MAINPATH,'rawdata'];
PATHOUT = [MAINPATH,'data\looping_03'];

cd (PATHIN); 


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % start eeglab 

EEG = pop_loadbv(PATHIN, 'PP_2020_02.vhdr', [], []);                        % load dataset 
EEG = pop_chanedit(EEG, 'lookup',[MAINPATH,...                              % Add channel location information 
    '\eeglab2021.0\eeglab2021.0\plugins\dipfit\standard_BEM\elec\standard_1005.elc']);
EEG = pop_epoch( EEG, {'S  1'  'S  2'}, [-1  2], 'epochinfo', 'yes');       % Epoch the data 
EEG = pop_rmbase( EEG, [-200 0] ,[]);                                       % Remove baseline from -200 to 0 ms. 

eeglab redraw;                                                              % Update EEGLAB gui 

