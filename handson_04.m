
clc; clear; clear all; 

addpath('C:\Users\Tammaso\OneDrive\Desktop\New Folder\EEG\eegl\eeglab2021.0');

MAINPATH = 'C:\Users\Tammaso\OneDrive\Desktop\New Folder\EEG\eegl';
PATHIN = [MAINPATH,'\rawdata\rawdata'];
PATHOUT = [MAINPATH,'\data\handson_04'];
mkdir(PATHOUT); 

SUB={'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04',...
    'PP_2020_05','PP_2020_06','PP_2020_07','PP_2020_08','PP_2020_09',...
    'PP_2020_10'};

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 

for s = 1:2     %length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB{s},'.vdhr'], [], []);
    EEG.setname = SUB{s}; 
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);
    EEG = pop_eegfiltnew(EEG, 'locutoff', 1); 
    EEG.setname = [EEG.setname '_1hz']; 
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); 
end 


start = 10;                                         % seconds 
stop = 20;                                          % seconds 
from = EEG.srate.*start;                            % start sample 
to = EEG.srate.*stop;                               % stop sample 
times = EEG.times(from:to)/1000;                    % form ms to sec 
chan = find(strcmp('Cz', {EEG.chanlocs.labels}));   % channel index 

figure; 
subplot(211); hold on; 
title([SUB{1} 'before & after filetring'], 'interp', 'none');
plot(times, ALLEEG(1).data(chan, from:to), 'k'); 
plot(times, ALLEEG(2).data(chan, from:to), 'k'); 
xlabel('Recording interval [sec]'); 
ylabel('Amplitude []')
grid on; axis tight; 

subplot(212); hold on; 
title([SUB{2} 'before & after filetring'], 'interp', 'none');
plot(times, ALLEEG(3).data(chan, from:to), 'k'); 
plot(times, ALLEEG(4).data(chan, from:to), 'k'); 
xlabel('Recording interval [sec]'); 
ylabel('Amplitude []')
grid on; axis tight; 

cd(PATHOUT); 
saveas(gcf, 'filter_effects','png'); 
close; 



%% 


clc; clear; clear all; 

addpath('C:\Users\Tammaso\OneDrive\Desktop\New Folder\EEG\eegl\eeglab2021.0');

MAINPATH = 'C:\Users\Tammaso\OneDrive\Desktop\New Folder\EEG\eegl';
PATHIN = [MAINPATH,'\rawdata\rawdata'];
PATHOUT = [MAINPATH,'\data\handson_04'];
mkdir(PATHOUT); 

SUB={'PP_2020_00','PP_2020_01','PP_2020_02','PP_2020_03','PP_2020_04',...
    'PP_2020_05','PP_2020_06','PP_2020_07','PP_2020_08','PP_2020_09',...
    'PP_2020_10'};

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 

data = []; 
start = 10;                                         % seconds 
stop = 20;  

for s = 1:2     %length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB{s},'.vdhr'], [], []);
    
    chan = find(strcmp('cz',{EEG.chanlocs.labels}));
    data(s,1,:)= EEG.data(chan,form:to);
    EEG = pop_eegfiltnew(EEG, 'locutoff', 1, 'plotfrqz',0); 
    data(s,2,:)=EEG.data(chan,from:to);
end 


from = EEG.srate.*start;                            % start sample 
to = EEG.srate.*stop;                               % stop sample 
times = EEG.times(from:to)/1000;                    % form ms to sec 
chan = find(strcmp('Cz', {EEG.chanlocs.labels}));   % channel index 

figure; 
subplot(211); hold on; 
title([SUB{1} 'before & after filetring'], 'interp', 'none');
plot(times, ALLEEG(1).data(chan, from:to), 'k'); 
plot(times, ALLEEG(2).data(chan, from:to), 'k'); 
xlabel('Recording interval [sec]'); 
ylabel('Amplitude []')
grid on; axis tight; 

subplot(212); hold on; 
title([SUB{2} 'before & after filetring'], 'interp', 'none');
plot(times, ALLEEG(3).data(chan, from:to), 'k'); 
plot(times, ALLEEG(4).data(chan, from:to), 'k'); 
xlabel('Recording interval [sec]'); 
ylabel('Amplitude []')
grid on; axis tight; 

cd(PATHOUT); 
saveas(gcf, 'filter_effects','png'); 
close; 

