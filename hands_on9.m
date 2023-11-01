%% Session 9 

clear all; close all; clc; 

MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl'; 
PATHIN = [MAINPATH,'\rawdata']; 
PATHOUT = [MAINPATH,'\data\hands-on9']; 
CHAN = 'C:\\Users\\japneet\\Desktop\\Courses atm\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc';

mkdir(PATHOUT); 
cd(MAINPATH); 

HPF = 0.3;
LPF = 30;
FROM = -0.2;
TO = 2;
REJ = 100; 

EVENTS = {'S1','S2'}; 
LABELS = {'standard','target'}; 

SUB = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'}; 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for i = 1:length(SUB)

    EEG = pop_loadbv(PATHIN, [SUB{i},'.vhdr'], [], []);
    EEG.setname = SUB{i}; 
    EEG=pop_chanedit(EEG, 'lookup', CHAN);
    EEG = pop_eegfiltnew(EEG, 'locutoff',LPF);
    EEG = pop_eegfiltnew(EEG, 'hicutoff',HPF);
    
    EEG = pop_epoch( EEG, {  'S  1'  'S  2'  }, [-2  8], 'epochinfo', 'yes');
    EEG = pop_rmbase( EEG, [-200 0] ,[]);
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);
    

end
