clear all; close all; clc; 

%% 1. Set path variables 
MAINPATH = 'C:\Users\japneet\Desktop\EEG\eegl'; 
PATHIN = [MAINPATH,'\rawdata'];
PATHOUT = [MAINPATH, '\data\trying_everything_again']; 
CHANLOC = 'C:\\Users\\japneet\\Desktop\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'; 
cd(PATHIN); 

%% 3. Add channel locations, plot topo maps and save dataset 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % start eeglab 
EEG = pop_loadbv(PATHIN, 'PP_2020_03.vhdr', [], []);                        % load dataset 1, all chans, all samples 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off');           % create a new dataset
EEG = eeg_checkset( EEG );                                                  % confirm all data needed is present 
EEG = pop_chanedit(EEG, 'lookup',CHANLOC);                                  % add chan location info
pop_eegplot( EEG, 1, 1, 1);                                                 % plot data > plot > chan scroll 

figure;                                                                     % plot topographical data after adding the channel location 
topoplot([],EEG.chanlocs, 'style', 'blank',  'electrodes', 'numpoint', ...
    'chaninfo', EEG.chaninfo);

EEG = pop_saveset( EEG, 'filename','chanlocs.set','filepath',PATHOUT);      % save data 

eeglab redraw;                                                              % refresh eeglab gui 


%% 4. Run a loop to get multiple datasets datasets, chanloc info and save datasets  

data = {'PP_2020_00.vhdr','PP_2020_01.vhdr','PP_2020_03.vhdr'}; 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

for s = 1:length(data)
EEG = pop_loadbv(PATHIN, data{s}, [], []);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname',data{s},'gui','off'); 
EEG=pop_chanedit(EEG, 'lookup',CHANLOC);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = pop_saveset( EEG, 'filename',[data{s},'.set'],'filepath',PATHOUT);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end
            
eeglab redraw; 

%% 5. Load previously created datasets 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','oyye.set','filepath',PATHIN);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );

eeglab redraw; 

%% 6. Exercise: If there is an event 'S 12' right after the event 'S 1', 
%     then it contains some noise. So, you need to average the latencies 


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadbv(PATHIN, 'PP_2020_02.vhdr', [], []);

eeglab redraw; 

for i=1:length(EEG.event)
    disp(EEG.event(i).type)
    if strcmpi(EEG.event(i).type,'S 1') & strcmpi(EEG.event(i+1).type,'S 12')
        EEG.event.latency = 
    end
end

data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};  % var with dataset names 
    
pnts = [];                                                                  % empty var for adding length of all datasets 

%% 7. 

% 1. start eeglab 
% 2. for several datasets 
    % import dataset 
    % add channel locations 
    % extract the length of the data (EEG.pnts) in a variable
    % save your dataset 
% plot the results stored in your variable 
% save the plot as a figure 

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;                                 % start eeglab 

data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};  % var with dataset names 
    
pnts = [];                                                                  % empty var for adding length of all datasets 

for i = 1:length(data)                                                          % loops runs from 1 till the length of data var
    EEG = pop_loadbv(PATHIN, [data{i},'.vhdr'], [], []);                        % load dataset 
    EEG = pop_chanedit(EEG, 'lookup', CHANLOC);                                 % add channel location information 
    EEG = eeg_checkset( EEG );                                                  % check if the data matches the required fields 
    EEG = pop_saveset( EEG, 'filename', [data{i}, '.set'],'filepath', PATHOUT); % save datasets 
    [ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);                         % store dataset info in the vars 
    pnts(i) = EEG.pnts;
end

eeglab redraw;                                                              % restore eeglab gui 
figure ; plot(pnts); title('Dataset lengths');                              % plot lengths of the datasets 
cd(PATHOUT); 
saveas(gca, 'dataset_names', 'png');                                        % save plots 

%% 8. Filter data, plot channel cz before and after the filtering before
% Start EEGLAB
% For two datasets:
% Import a dataset
% Apply a 1 Hz high-pass filter
% Store all four datasets in ALLEEG
% When you are done, plot the data of channel Cz, from
% second 10 to 20, before and after filtering, as an overlay.
% Try to combine the data of both datasets into one plot,
% using subfigures.


cd(PATHIN); 

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;                                    % start eeglab 
data = {'PP_2020_00','PP_2020_01'};                                         % datasets for the loop to go through 
chan = [];                                                                  % channel info var 

for i=1:length(data)                                                        % loop runs till the length of the data matrix 
    EEG = pop_loadbv(PATHIN, [data{i},'.vhdr'], [], []);                              % load datasets 
    EEG.setname = data{i};                                                  % give dataset names 
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);                      % add the new dataset to the ALLEEG 
    EEG = pop_eegfiltnew(EEG, 'hicutoff',1,'plotfreqz',1);                  % filter the data with 1 hz high pass filter  
    EEG.setname = [data{i},'_filt_1hz'];                                    % new dataset after filtering 
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);                      % save the filtered data in ALLEEG
    chan = find(strcmp('Cz',{EEG.chanlocs.labels}));                        % find the position of the 'Cz' label from all the datasets extracted 
    eeglab redraw;  
end  

% Extract the time information from 10 to 20 seconds for dataset 1 
start = 10; %sec 
stop = 20; %sec 
from = EEG.srate*start; 
to = EEG.srate*stop; 
times = EEG.times(from:to); 

% Plot the data from 10 to 20 secs in fubfigures for dataset 2
figure; 
subplot(1,2,1); hold on; 
title(ALLEEG(1).setname,'filtered and unfiltered'); 
plot(times,ALLEEG(1).data(chan,from:to),'b'); 
plot(times,ALLEEG(2).data(chan,from:to),'y'); 
xlabel('time'); 
ylabel('filtered and unfiltered data'); 
grid on; axis tight; 

% Plot the data from 10 to 20 secs in fubfigures 
 
subplot(1,2,2); hold on; 
title(ALLEEG(3).setname,'filtered and unfiltered'); 
plot(times,ALLEEG(3).data(chan,from:to),'b'); 
plot(times,ALLEEG(4).data(chan,from:to),'y'); 
xlabel('time'); 
ylabel('filtered and unfiltered data'); 
grid on; axis tight; 

%% 9. processing data 
% 
% Start EEGLAB
    % For two datasets:
    % import a dataset
    % calculate standard deviation for *each channel     !!!!!!!!!!!
    % store dataset in ALLEEG
    % apply a 1 Hz high-pass filter
    % calculate standard deviation for each channel 
    % store dataset in ALLEEG
% Plot the standard deviations as maps, into a single
% figure using subplot. Use the same scale for all maps.

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;

data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};


for i = 1:2
    % Unfiltered dataset 
    EEG = pop_loadbv(PATHIN,[data{i},'.vhdr'],[],[]);                            % load dataset 
    EEG.setname = [data{i},'_unfilt'];                                      % set name for unfiltered dataset 
    EEG = pop_chanedit(EEG,'lookup',CHANLOC);                               % add channel location information  
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);                       % store in ALLEEG
     
    % Filtered dataset     
    EEG = pop_eegfiltnew(EEG, 'hicutoff',1,'plotfreqz',1);
    EEG.setname = [data{i},'_filt'];                                        % set name of filtered data 
    [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG);                     % store in ALLEEG

    eeglab redraw;
end

stdv = []; 
% run a loop to calculate std and plot 4 subplots of std against chanloc in 1 fig  
for a = 1:4       % everything runs 4 times 
    stdv(a,:) = std(ALLEEG(a).data');                                         % calculate std of filtered and unfiltered data 
end

val = ceil(max(abs(stdv(:))));

figure; 
for b = 1:4
    subplot(2,2,b); hold on;                                                % open a subplot, with 4  blocks 
    topoplot(stdv(b,:),ALLEEG(b).chanlocs,'maplimits',[-val,val]);       % create a topoplot for std values of chans agains the channel location, with the same scale for each graph  
    colorbar;
    title(ALLEEG(b).setname, 'interp', 'none');
end

cd(PATHOUT); 
saveas(setgcf,'Std_dev before and after filtering 2 datasets','png')

eeglab redraw; 

%% 10. Find and remove empty channels data from all the datasets 
cd(PATHIN); 

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;                                    % start eeglab 
data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'};  % all datasets 

for i = 1:length(data)                                                      % loop through all datasets 
    
    EEG = pop_loadbv(PATHIN, [data{i},'.vhdr'], [], []);                    % load datasets
    rem_chan = find(cellfun(@isempty,{EEG.chanlocs.X}));                    % identify empty elements indices 
    EEG = pop_select(EEG, 'nochannel', rem_chan);                           % remove emopty channels 
    EEG.setname = data{i};                                                  % setname 
    [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG);                       % store in ALLEEG 
  %   EEG = pop_saveset( EEG, [data{i},'.set'],'filepath',PATHOUT);           % save dataset in PATHOUT 

end

eeglab redraw; 


%% 11. %% Quick and dirty preprocessing 
% ICFEBReDCERP 

clear all; close all; clc; 
MAINPATH = 'C:\Users\japneet\Desktop\EEG\eegl'; 
PATHIN = [MAINPATH,'\rawdata']; 
PATHOUT = [MAINPATH,'\data\trying_everything_again']; 
CHANLOC = 'C:\\Users\\japneet\\Desktop\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'; 
cd(PATHIN); 

FROM = -2; %sec 
TO = 7.996; %sec 
h_filt = 0.3; %hz 
l_filt = 30; %hz 
AMP = 100; %microvolt
EVENTS = {'S 1','S 2'};     % standard and target events 
LABELS = {'standard','target'}; 

data = {'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04'}; 

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;

for i=1:2
    EEG = pop_loadbv(PATHIN, [data{i},'.vhdr'], [], []);
    EEG = pop_chanedit(EEG, 'lookup', CHANLOC);
    EEG = pop_eegfiltnew(EEG, 'locutoff', 30, 'hicutoff', 0.3, 'plotfreqz',1);
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, {  'S  1'  'S  2'  }, [FROM TO]);
    EEG = pop_rmbase( EEG, [-200 0] ,[]);
    EEG = pop_eegthresh(EEG,1,[1:32] ,-AMP, AMP, FROM, TO, 0, 0);
    [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG); 
    
        % To create dataset for each condition of interest 
    for a = 1:length(EVENTS)
        EEG = pop_selectevent(EEG, 'latency', '-2<=2', 'type', {'S  1','S  2'});

        EEG.setname = [data{i}, LABELS{a}]; 
        
        % save dataset per condition 
        EEG = pop_saveset(EEG, 'filename', [EEG.setname, '.set'], 'filepath', PATHOUT); 
        [ALLEEG, EEG, ~] = eeg_store(ALLEEG, EEG); 
%         d = d+1;
    end
    
end

% d = 1; 


eeglab redraw; 

% Create ERP and GFP 
time = ALLEEG(2).times;
erp = mean(ALLEEG(2).data,3); 
gfp = std(erp); 

% Plot ERP and GFP as overlay 
figure; 
plot(time, erp, 'k'); hold on; 
plot(time, gfp, 'r', 'linew', 2); 
xlabel('Time [ms]'); 
ylabel('Amp [uV]'); 

%find GFP peak and plot 
[a,f] = max(gfp);
figure; 
topoplot(erp(:,f),EEG.chanlocs);
title; 
colorbar; 

%% Global field power 
% Use the datasets for the target condition as created in Hands-on 8
% Explore different ways of plotting ERPs using the GUI
% Create an ERP yourself, by averaging EEG.data over the third dimension
% As an estimate of signal strength across all channels, calculate for 
%   each frame the standard deviation of the ERP. 
% Plot the resulting GFP, maybe as an overlay to all channel ERPs
% Find the peak latency of the GFP and plot the ERP map

clear all; close all; clc; 

MAINPATH = 'C:\Users\japneet\Desktop\Courses atm\EEG\eegl'; 
PATHIN = [MAINPATH,'\rawdata']; 
PATHOUT = [MAINPATH,'\data\hands-on9']; 
CHANLOC = 'C:\\Users\\japneet\\Desktop\\Courses atm\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc';

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

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;

for i = 1:length(SUB)

    EEG = pop_loadbv(PATHIN, [SUB{i},'.vhdr'], [], []);
    EEG.setname = SUB{i}; 
    EEG=pop_chanedit(EEG, 'lookup', CHAN);
    EEG = pop_eegfiltnew(EEG, 'locutoff',LPF);
    EEG = pop_eegfiltnew(EEG, 'hicutoff',HPF);
    
    EEG = pop_epoch( EEG, {  'S  1'  'S  2'  }, [-2  8], 'epochinfo', 'yes');
    EEG = pop_rmbase( EEG, [-200 0] ,[]);
    [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG);
    

end













