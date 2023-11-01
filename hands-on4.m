%% ------- HANDS ON 4 ---------- 
% Start EEGLAB 
% For 2 datasets 
    % Import dataset 
    % Apply a 1 Hz high-pass filter
    % Store all four datasets in ALLEEG
% plot the data of channel Cz, from second 10 to 20, before and after 
% filtering, as an overlay. Try to combine the data of both datasets into 
% one plot, using subfigures.
    % (extract the 'Cz' channel's data from 10 to 20 secs 
    %  make one plot with subfigs 
    %  before filtering 
    %  same data after filtering) 

clear all; close all; clc;                                                  % clear workspace 

MAINPATH = 'C:\Users\japneet\Desktop\EEG\eegl';                 % save vars for data paths 
PATHIN = [MAINPATH,'\rawdata']; 
PATHOUT = [MAINPATH, '\data\hand-on4..']; 
CHANS = 'C:\\Users\\japneet\\Desktop\\EEG\\eegl\\eeglab2021.0\\eeglab2021.0\\plugins\\dipfit\\standard_BEM\\elec\\standard_1005.elc'; 

% mkdir(PATHOUT);                                                           % Create the pathout directory  

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;                                    % start eeglab 

data = {'PP_2020_00.vhdr','PP_2020_01.vhdr'};                               % dataset cell array  
chan = [];                                                                  % empty chan matrix



for i=1:length(data)                                                        % loop runs till the length of the data matrix 
    EEG = pop_loadbv(PATHIN, data{i}, [], []);                              % load datasets 
    EEG.setname = data{i};                                                  % give dataset names 
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);                      % add the new dataset to the ALLEEG 
    EEG = pop_eegfiltnew(EEG, 'hicutoff',1,'plotfreqz',1);                  % filter the data with 1 hz high pass filter  
    EEG.setname = [data{i},'_filt_1hz'];                                    % new dataset after filtering 
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);                      % save the filtered data in ALLEEG
    chan = find(strcmp('Cz',{EEG.chanlocs.labels}));                        % find the position of the 'Cz' label from all the datasets extracted 
    eeglab redraw;  
end                                                                         % end for loop 

start = 10;                                                                 % sec 
stop = 20;                                                                  % sec 

from = EEG.srate*10;                                                        % sample data from time point 10 sec
to = EEG.srate*20;                                                          % sample data till time point 20 sec

times = EEG.times(from:to)/1000;                                            % convert the data to ms and extract it from times. 

% plot data from channel 'cz' saved in 'chan'
% from 10 sec to 20 sec 'from' 'to'
% before and after filtering 'ALLEEG(1)

% EEG.data: rows*cols with the actual EEG data 

figure;                                  % open a figure 
subplot(1,2,1); hold on;                 % create a subplot, 1 row, 2 cols, 1st element 
title([ALLEEG(1).setname,'before & after filtering'],'interp','none'); 
plot(times, ALLEEG(1).data(chan,from:to),'k'); % plot the 1st dataset unfiltered 
plot(times, ALLEEG(2).data(chan,from:to),'y'); % plolt the 1st dataset filtered
xlabel('Recording interval [sec]'); 
ylabel('Amplitude [uV]'); 
grid on; axis tight; 

subplot(1,2,2); hold on;                 % create a subplot, 1 row, 2 cols, 1st element 
title([ALLEEG(3).setname,'before & after filtering'],'interp','none'); 
plot(times, ALLEEG(1).data(chan,from:to),'k'); % plot the 1st dataset unfiltered 
plot(times, ALLEEG(2).data(chan,from:to),'y'); % plolt the 1st dataset filtered
xlabel('Recording interval [sec]'); 
ylabel('Amplitude [uV]'); 
grid on; axis tight; 

cd(PATHOUT); 
saveas(gcf, 'filtering effects', 'png'); 
% close; 


