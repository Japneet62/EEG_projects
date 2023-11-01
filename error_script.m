clc; clear; clear all; 


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadbv(PATHIN, 'PP_2020_03.vhdr', [1 325120], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32]);
 eeglab redraw; 

for s = 1:length(SUB)
    EEG = pop_loadbv(PATHIN, [SUB(s), '.vdhr']);
    % EEG = pop_chanedit(EEG,'lookup', [MAINPA TH, ...
      %   'eeglab2021.0/eeglab2021.0/plugins/dipfit/standard_BEM/elec/standard_1005.elc']); 
    % EEG.setname=SUB(s);
   disp(SUB(s));
end 

eeglab redraw; 