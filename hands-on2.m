%% ------ HANDS ON SESSION 2: Channel info, topographical map, save dataset ------- %% 
% 1. add channel location info - GUI/code
% 2. Plot a topographical map with channel location information  - GUI/code
% 3. save dataset  - GUI/code
% 4. Run all the steps given above in a loop  - code
% 5. Load previously created datasets  - GUI/code
% 6. Exercise: The event 'S 12' contains some noise. So, 

% clear workspace of unnecessary variables 
clear all; close all; clc;                                      

% ADD PATH variables to go to different directories
MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl\';
PATHIN = [MAINPATH,'rawdata'];
PATHOUT = [MAINPATH,'data\hands-on2'];

% mkdir(PATHOUT); 
% Set the path to access the files needed 
cd(MAINPATH);

%% Add channel info using GUI 
% load data
% edit>channel locations >ok>ok
% then you see there 'yes' in the channel locations column in the GUI


%% Add channel info using code

% eegh
% code recieved

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % start eeglab 
EEG = pop_loadbv(PATHIN, 'PP_2020_03.vhdr', [], []);                        % load dataset 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');           % create new dataset in the eeg space
EEG = eeg_checkset( EEG );                                                  % check condidtency of EEG fields

% get eeg channel location info
EEG=pop_chanedit(EEG, 'lookup','C:\\Users\\japneet\\Desktop\\Courses atm\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc');

% store specified datasets in ALLEEG
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);

% Plot a topographical map with channel location information 
EEG = eeg_checkset( EEG );
figure; 
topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'labelpoint', ...
    'chaninfo', EEG.chaninfo);

% Save dataset 
EEG = pop_saveset( EEG, 'filename','hands-on_02.set','filepath',PATHOUT);

% Update eeglab 
eeglab redraw; 

%% Run the following steps in a loop 
% 1. start eeglab 
% 2. load 2 dataset
% 3. set the name od the datasets 
% 4. add channel location info 
% 5. save datasets 
% 6. update eeglab 

clear all; close all; clc;                                                  % Close all the unnecessary tabs and vars 

MAINPATH = 'C:\Users\japneet\Desktop\EEG\eegl';                 % path var where all the files are 
PATHIN = [MAINPATH,'\rawdata'];                                             % path var to extract the raw data 
PATHOUT = [MAINPATH,'\data\hands-on2.m'];                                   % path var to save the final processed datasets 
CHANS = 'C:\\Users\\japneet\\Desktop\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'

% mkdir(PATHOUT);                                                             % Create the PATHOUT dir

data = {'PP_2020_00.vhdr','PP_2020_01.vhdr'};                               % create a cell array with all the dataset names 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % Start eeglab 

for s=1:length(data)                                                        % create a loop that runs till the length of the data var 
    EEG = pop_loadbv(PATHIN, data{s},[], []);                               % load the dataset at the position 's' from the 'data' cell array  
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname',...       % add dataset name 
        data{s}, 'gui','off');      
    EEG=pop_chanedit(EEG, 'lookup',CHANS);                                  % add channel location information 
    EEG = eeg_checkset( EEG );                                              % check if the data matches the required fields 
    EEG = pop_saveset( EEG, 'filename',[data{s},'.set'],'filepath',PATHOUT);% save datasets 
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);                      % store all the specified info in the ALLEEG 
end


eeglab redraw;                                                              % Update the eeglab gui 

%% Load previously created dataset 
clear all; close all; clc;
MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl\';
DATA = [MAINPATH,'\data\hands-on2'];  

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','hands-on_02.set','filepath',DATA);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw; 

%% For one particular dataset, extract the latencies for the events 'S 1' and 'S 12' 

% 6. Exercise: If there is an event 'S 12' right after the event 'S 1', then 
% it contains some noise. So, you need to average the latencies 


clear all; close all; clc; 

MAINPATH = 'C:\Users\japneet\Desktop\EEG\eegl\';
PATHIN = [MAINPATH,'\rawdata']

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % start eeglab 

all_lats = [];                                                              % Create an empty matrix to save the latency info 
EEG = pop_loadbv(PATHIN, 'PP_2020_01.vhdr',[], []);                         % load the PP_2020_01 dataset 

for e = 1:length(EEG.event) -1                                              % run the loop from 1 till the 1 - length of the the fiels EEG.event
                        % why EEG.event -1?
    if strcmpi(EEG.event(e).type,'S 1') & strcmpi(EEG.event(e+1).type, ...  % check the latencies when the event type is 'S1 and exactly after 'S 1' you have 'S12' 
            'S 12')                                                         % both the statements should be true to enter the if statememt 
        rt = EEG.event(e+1).latency - EEG.event(e).latency;                 % subtract the 'S12' latency value from the 'S1' latency value
        all_lats(end+1) = rt/EEG.srate*1000;                                % averaging 
    end
end



figure; 
hist(all_lats,50)

eeglab redraw; 




