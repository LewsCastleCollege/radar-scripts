function [] = GetBackscatter2(folderdir, startTime, endTime)
     % deployed buoy locations
    buoy40GPS = 'd:\Angus\MATLAB\GPS\03_16_40cm_UNE.csv';
    buoy70GPS = 'd:\Angus\MATLAB\GPS\03_16_70cm_UNE.csv';
    [gps,tStamp,~] = xlsread(buoy40GPS);
    [~,ind1] = min(abs(datenum(tStamp)-datenum(startTime)));
    buoy40loc = gps(ind1,3:4);
    [gps,tStamp,~] = xlsread(buoy70GPS);
    [~,ind1] = min(abs(datenum(tStamp)-datenum(startTime)));
    buoy70loc = gps(ind1,3:4);
    
    % sensor locations
    adcploc1 = 617753.2886;
    adcploc2 = 6415732.6997;
    ps2loc1 = 617660.1039;
    ps2loc2 = 6415731.542;
    [BUOY40_PULSE, BUOY40_BIN, BUOY40_DIS, BUOY40_ANG] = GetPulseBin(buoy40loc(1), buoy40loc(2));
    [BUOY70_PULSE, BUOY70_BIN, BUOY70_DIS, BUOY70_ANG] = GetPulseBin(buoy70loc(1), buoy70loc(2));
    [ADCP_PULSE, ADCP_BIN, ADCP_DIS, ADCP_ANG] = GetPulseBin(adcploc1, adcploc2);
    [PS2_PULSE, PS2_BIN, PS2_DIS, PS2_ANG] = GetPulseBin(ps2loc1, ps2loc2);

    currentFolder = pwd;
    cd(folderdir);
    
    folderlist = dir('*.mat');    % get list of mat files
    folderlist = SortDirFiles(folderlist);
    timestamps = str2double(strrep(folderlist,'.mat',''));
    
     % find mat file(s) that encompass time range
    sd = datenum(Win2mat_timeconvert(timestamps)) - ...
        datenum(startTime,'dd/mm/yyyy HH:MM:SS');        
    startIndex = length(find(sd <= 0))
    ed = datenum(Win2mat_timeconvert(timestamps)) - ...
        datenum(endTime,'dd/mm/yyyy HH:MM:SS');       
    endIndex = length(find(ed <= 0))
    %{
    mFile = matfile(folderlist{startIndex});
    buoy40s = double(squeeze(mFile.Stamp(BUOY40_PULSE,:)));
    buoy40i = double(squeeze(mFile.Image(BUOY40_BIN,BUOY40_PULSE,:)));
    buoy70s = double(squeeze(mFile.Stamp(BUOY70_PULSE,:)));
    buoy70i = double(squeeze(mFile.Image(BUOY70_BIN,BUOY70_PULSE,:)));
    adcps = double(squeeze(mFile.Stamp(ADCP_PULSE,:)));
    adcpi = double(squeeze(mFile.Image(ADCP_BIN,ADCP_PULSE,:)));
    ps2s = double(squeeze(mFile.Stamp(PS2_PULSE,:)));
    ps2i = double(squeeze(mFile.Image(PS2_BIN,PS2_PULSE,:)));
   size(buoy40s)
    %}
    cd(currentFolder);
end