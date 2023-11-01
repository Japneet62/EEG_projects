%% Quick and dirty preprocessing 
% 1. Import raw data 
% 2. add channel info
% 3. apply 0.3 hc high pass filter
% 4. apply 30 hz low pass filter 
% 5. epoch data from -200 to 800 ms using target and standard as time
% locking evets
% 6. remove baseline from -200 to 0 ms. 
% 7. Reject epochs with amplitudes exceding 100 mv. ?
% 8. create datasets for each condition of interest ?
% 9. Compare ERPs before and after correction ? 

%% For 1 participant 

clear all; close all; clc; 

MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl\';                % Setting up path variables 
PATHIN = [MAINPATH,'rawdata'];
PATHOUT = [MAINPATH,'data\looping_03'];

cd (PATHIN); 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % Start eeglab 
EEG = pop_loadbv(PATHIN, 'PP_2020_03.vhdr', [], []);                        % load eeg dataset
EEG=pop_chanedit(EEG,...                                                    % Add channel location information 
    'lookup','C:\\Users\\japneet\\Desktop\\Courses atm\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc');

EEG = pop_eegfiltnew(EEG, 'locutoff',30,'hicutoff',0.3,'plotfreqz',1);      % Apply 0.3 hz high pass filter and 30 hz low pass filter 

EEG = pop_epoch( EEG, {  'S  1'  'S  2'  }, [-1  2], 'newname',...          % Epoch the data with S1 and S2 events selected 
    'preprocessed epochs', 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-200 0] ,[]);                                       % Remove baseline from -200 to 0 ms. 

                                                                            % Reject epochs with amplitudes exceding 100 mv.
                                                                            % create datasets for each condition of interest 
                                                                            % Compare ERPs before and after correction 
                                                                            
eeglab redraw;                                                              % Update eeglab gui



%% for multiple participants 
clear all; close all; clc; 


MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl\';                % Setting up path variables 
PATHIN = [MAINPATH,'rawdata'];
PATHOUT = [MAINPATH,'data\looping_03'];

cd (PATHIN); 

SUB={'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};     % Create a list with all subject file names 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % Start eeglab 
    
for s=1:length(SUB)                                                         % Run a loop through all the eeg files 
    EEG = pop_loadbv(PATHIN, [SUB{s} '.vhdr'], [], []);                     % load eeg dataset
    EEG.setname=SUB(s);                                                     % Set filenames 
    EEG=pop_chanedit(EEG, 'lookup',[MAINPATH,...                            % Add channel location information 
        '\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc']);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    
    
    EEG = pop_eegfiltnew(EEG, 'locutoff',30,'hicutoff',0.3,'plotfreqz',1);  % Apply 0.3 hz high pass filter and 30 hz low pass filter 

    
    EEG = pop_epoch( EEG, {  'S  1'  'S  2'  }, [-2  8], 'newname',...      % Epoch the data with S1 and S2 events selected 
    'preprocessed epochs', 'epochinfo', 'yes');
    EEG = pop_rmbase( EEG, [-200 0] ,[]);                                   % Remove baseline from -200 to 0 ms. 

    eeglab redraw;                                                          % Update eeglab gui

    
end
