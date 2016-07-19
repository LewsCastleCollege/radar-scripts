function [buoy40, buoy70, adcp, ps2, locations] = GetBackscatter0(folderdir, startTime, endTime)
%% Get backscatter values from defined time limits and locations

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
    startIndex = length(find(sd <= 0));
    ed = datenum(Win2mat_timeconvert(timestamps)) - ...
        datenum(endTime,'dd/mm/yyyy HH:MM:SS');        
    endIndex = length(find(ed <= 0));
   
    % load file(s)
    if (startIndex == endIndex)
        load(folderlist{timestampindex(1)});
    elseif ((endIndex - startIndex) == 1)
        f1 = load(folderlist{startIndex});
        f2 = load(folderlist{endIndex});
        Image = cat(3,f1.Image,f2.Image);
        Stamp = cat(2,f1.Stamp,f2.Stamp);
        clearvars f1 f2;
    elseif ((endIndex - startIndex) == 2) % maximum allowed
        f1 = load(folderlist{startIndex});
        f2 = load(folderlist{startIndex+1});
        f3 = load(folderlist{endIndex});
        tImage = cat(3,f1.Image,f2.Image);
        Image = cat(3,tImage,f3.Image);
        tStamp = cat(2,f1.Stamp,f2.Stamp);
        Stamp = cat(2,tStamp,f3.Stamp);
        clearvars f1 f2 f3 tImage tStamp;
    end
    
    % extract full range of sensor point data
    buoy40f = zeros(size(Stamp,2),2);
    buoy70f = zeros(size(Stamp,2),2);
    adcpf = zeros(size(Stamp,2),2);
    ps2f = zeros(size(Stamp,2),2);
    for rot=1:size(Stamp,2) % number of columns equals number of rotations
        buoy40f(rot,1) = Stamp(BUOY40_PULSE,rot);
        buoy40f(rot,2) = Image(BUOY40_BIN,BUOY40_PULSE,rot);
        buoy70f(rot,1) = Stamp(BUOY70_PULSE,rot);
        buoy70f(rot,2) = Image(BUOY70_BIN,BUOY70_PULSE,rot);
        adcpf(rot,1) = Stamp(ADCP_PULSE,rot);
        adcpf(rot,2) = Image(ADCP_BIN,ADCP_PULSE,rot);
        ps2f(rot,1) = Stamp(PS2_PULSE,rot);
        ps2f(rot,2) = Image(PS2_BIN,PS2_PULSE,rot);
    end
   
    % narrow range
    [~,startIndex] = min(abs(datenum(Win2mat_timeconvert(buoy40f(:,1)))- ...
        datenum(startTime,'dd/mm/yyyy HH:MM:SS')));
    [~,endIndex] = min(abs(datenum(Win2mat_timeconvert(buoy40f(:,1)))- ...
        datenum(endTime,'dd/mm/yyyy HH:MM:SS')));
    
    %extract exact range of data
    buoy40(:,1) = buoy40f(startIndex:endIndex,1);
    buoy40(:,2) = buoy40f(startIndex:endIndex,2);
    buoy70(:,1) = buoy70f(startIndex:endIndex,1);
    buoy70(:,2) = buoy70f(startIndex:endIndex,2);
    adcp(:,1) = adcpf(startIndex:endIndex,1);
    adcp(:,2) = adcpf(startIndex:endIndex,2);
    ps2(:,1) = ps2f(startIndex:endIndex,1);
    ps2(:,2) = ps2f(startIndex:endIndex,2);
    
    % store metadata
    locations.buoy40easting = buoy40loc(1);
    locations.buoy40northing = buoy40loc(2);
    locations.buoy40pulse = BUOY40_PULSE;
    locations.buoy40bin = BUOY40_BIN;
    locations.buoy40dis = BUOY40_DIS;
    locations.buoy40ang = BUOY40_ANG;
    locations.buoy70easting = buoy70loc(1);
    locations.buoy70northing = buoy70loc(2);
    locations.buoy70pulse = BUOY70_PULSE;
    locations.buoy70bin = BUOY70_BIN;
    locations.buoy70dis = BUOY70_DIS;
    locations.buoy70ang = BUOY70_ANG;
    locations.adcpeasting = adcploc1;
    locations.adcpnorthing = adcploc2;
    locations.adcppulse = ADCP_PULSE;
    locations.adcpbin = ADCP_BIN;
    locations.adcpdis = ADCP_DIS;
    locations.adcpang = ADCP_ANG;
    locations.ps2easting = ps2loc1;
    locations.ps2northing = ps2loc2;
    locations.ps2pulse = PS2_PULSE;
    locations.ps2bin = PS2_BIN;
    locations.ps2dis = PS2_DIS;
    locations.ps2ang = PS2_ANG;
    
    cd(currentFolder);
end