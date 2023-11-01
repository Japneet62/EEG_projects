%% -------- Handson session 8 -------------
% AIM: Data epoching, creating condition specifc datasets 
% Import raw data 
% Add channel location info 
% Apply 0.3 high pass filter
% Apply 30 hz low pass filter
% epoch data from -200 to 800 ms, using target and time locking events 
% remove baseline from -200 to 0 ms. 
% Reject epochs with amplitudes exceeding 100uV
% Create datasets for each condition of interest 
% compare ERPs before and after preprocessing. (plotting?)

clear all; close all; clc; 

MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl';
CHAN = 'C:\\Users\\japneet\\Desktop\\Courses atm\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'; 
PATHIN = [MAINPATH,'\rawdata'];
PATHOUT = [MAINPATH,'\data\handson-8'];

cd(MAINPATH);       
% mkdir(PATHOUT);                                                           % create workout directory  

data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};  % dataset var 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % start eeglab 

EEG = pop_loadbv(PATHIN, 'PP_2020_02.vhdr', [], []);                        % load dataset 

EEG.setname = 'PP_2020_02';                                                 % add dataset name   
EEG = pop_chanedit(EEG, 'lookup',CHAN);                                     % add channel locations


% rm_chan = find(cellfun(@isempty{EEG.chanlocs.x})); 

% [ALLEEG EEG] = eeg_store(ALLEEG, EEG);                                      % store dataset in ALLEEG
EEG = pop_eegfiltnew(EEG,'locutoff',30,'plotfreqz',1);                      % filter the data with 0.3 hz highpass and 30 hz low pass frequency 
EEG = pop_eegfiltnew(EEG,'hicutoff',0.3,'plotfreqz',1);
EEG.setname = ['PP_2020_02','filtered'];                                    % give name to the filtered dataset 
EEG = pop_epoch( EEG, {  'S  1'  'S  2'  }, [-2  8], 'newname', ...
    'PP_2020_02 epochs', 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-200 0] ,[]);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG);                                      % ? can  be skipped



EEG = pop_eegthresh(EEG,1,[1:31],-100,100,-0.2,0.8,0,1); 
eeglab redraw; 



%% Now do this same thing in a loop 

clear all; close all; clc; 

MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl';
CHAN = 'C:\\Users\\japneet\\Desktop\\Courses atm\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'; 
PATHIN = [MAINPATH,'\rawdata'];
PATHOUT = [MAINPATH,'\data\handson-8'];

cd(MAINPATH); 
% mkdir(PATHOUT);                                                           % create workout directory  

data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};  % dataset var 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % start eeglab 

for i = 1:2 
    
    EEG = pop_loadbv(PATHIN, 'PP_2020_02.vhdr', [], []);                        % load dataset 
    EEG.setname = data{i};                                                      % add dataset name   
    EEG = pop_chanedit(EEG, 'lookup',CHAN);                                     % add channel locations
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG);                                      % store dataset in ALLEEG
    EEG = pop_eegfiltnew(EEG, 'locutoff',30,'hicutoff',0.3,'plotfreqz',1);      % filter the data with 0.3 hz highpass and 30 hz low pass frequency 
    EEG.setname = [data{i},'filtered'];                                         % give name to the filtered dataset 
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG);                                      % store unfitered data in ALLEEG
    EEG = pop_epoch( EEG, {  'S  1'  'S  2'  }, [-2  8], 'newname', ...         % create epochs
    'PP_2020_02 epochs', 'epochinfo', 'yes');  
    EEG = pop_rmbase( EEG, [-200 0] ,[]);                                       % remove baseline from -200 to 0 ms
    
end


