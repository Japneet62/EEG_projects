%% ---------- HANDS ON SESSION 3. LOOPING ----------------- %% 

clc; clear; clear all; 

MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl\';
PATHIN = [MAINPATH,'rawdata'];
PATHOUT = [MAINPATH,'data\looping_03'];
cd (PATHIN); 

% var with dataset names 
SUB={'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};
   

%% RUN A LOOP THROUGH ALL THE FILES IN VAR "SUB"

for a = 1:length(SUB)       % run for loop through all the files of the var SUB
    disp(SUB(a)) % display the dataset names
    pause(1);     % pause the results when displaying by a gap of 1 sec for each loop iteration
end  

%% Run a loop to load all the files in var SUB

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for s=1:length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB{s} '.vhdr'], [], []); % load eeg dataset
end 

eeglab redraw

%% Run a loop to load all files in SUB, and give dataset a name

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for s=1:length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB{s} '.vhdr'], [], []); % load eeg dataset
    EEG.setname=SUB(s);
    [ALLEEG EEG CURRENTDATASET] = eeg_store(ALLEEG, EEG);
end 

eeglab redraw;y7

%% Loop to load multiple dataset and get their channel info 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for s=1:length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB{s} '.vhdr'], [], []); % load eeg dataset
    EEG.setname=SUB(s);
    EEG=pop_chanedit(EEG, 'lookup',[MAINPATH,'\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc']);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end 

eeglab redraw;


%% Save the number of samples per channel from each dataset into a new matrix

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

res = [];
for s=1:length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB{s} '.vhdr'], [], []); % load eeg dataset
    EEG.setname=SUB(s);
    EEG=pop_chanedit(EEG, 'lookup',[MAINPATH,'\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc']);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    res(s)=EEG.pnts;
end 

eeglab redraw;


%% Saving the datasets 

clc; clear; clear all; 

MAINPATH = 'C:\Users\Tammaso\OneDrive\Desktop\New Folder\EEG\eegl';
PATHIN = [MAINPATH,'\rawdata'];
PATHOUT = [MAINPATH,'\data\looping_03'];

cd (PATHIN); 

SUB={'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};
% SUB={'PP_2020_00'};
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

res = [];
for s=1:length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB{s} '.vhdr'], [], []); % load eeg dataset
    EEG=pop_chanedit(EEG, 'lookup',[MAINPATH,'\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc']);
    res(s)=EEG.pnts;
    EEG = pop_saveset(EEG, 'filename', [SUB{s}, '.set'],'filepath', PATHOUT);
end 
cd(PATHOUT)
saveas(gcf,'my_analysis','png'); % this step showed error. Check later

eeglab redraw;


%% 


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% res = [];
for s = 1:length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB(s), '.vdhr'], [], []);
    EEG.setname=SUB(s);
    [ALLEEG EEG CURRENTDATASET] = eeg_store(ALLEEG, EEG);
    
    EEG = pop_chanedit(EEG,'lookup', [MAINPATH, ...
        'eeglab2021.0/eeglab2021.0/plugins/dipfit/standard_BEM/elec/standard_1005.elc']); 
    
   % res(s)=EEG.pnts; 
   % EEG=pop_saveset(EEG, 'filename', [SUB(a), '.set'], 'filepath', PATHOUT);
    
end 

% cd (PATHOUT)
% saveas(gcf, 'length_datasets','png');

eeglab redraw; 













[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

EEG = pop_loadbv('C:\Users\Tammaso\OneDrive\Desktop\New folder\EEG\eegl\rawdata\rawdata\', 'PP_2020_00.vhdr', [1 334345], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]);
EEG = pop_chanedit(EEG, 'lookup','C:\\Users\\Tammaso\\OneDrive\\Desktop\\New folder\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc');
eeglab redraw


