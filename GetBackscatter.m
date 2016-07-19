function [buoy40, buoy70, adcp, ps2, locations] = GetBackscatter(folderdir, startTime, endTime)
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
   
    % extract full range of sensor point data
    mFile = matfile(folderlist{startIndex});
    buoy40s = double(squeeze(mFile.Stamp(BUOY40_PULSE,:)));
    buoy40i = double(squeeze(mFile.Image(BUOY40_BIN,BUOY40_PULSE,:)));
    buoy70s = double(squeeze(mFile.Stamp(BUOY70_PULSE,:)));
    buoy70i = double(squeeze(mFile.Image(BUOY70_BIN,BUOY70_PULSE,:)));
    adcps = double(squeeze(mFile.Stamp(ADCP_PULSE,:)));
    adcpi = double(squeeze(mFile.Image(ADCP_BIN,ADCP_PULSE,:)));
    ps2s = double(squeeze(mFile.Stamp(PS2_PULSE,:)));
    ps2i = double(squeeze(mFile.Image(PS2_BIN,PS2_PULSE,:)));
   
    for fInd=startIndex+1:endIndex
        mFile = matfile(folderlist{fInd});
        buoy40s = cat(2,buoy40s,double(squeeze(mFile.Stamp(BUOY40_PULSE,:))));
        buoy40i = cat(1,buoy40i,double(squeeze(mFile.Image(BUOY40_BIN,BUOY40_PULSE,:))));
        buoy70s = cat(2,buoy70s,double(squeeze(mFile.Stamp(BUOY70_PULSE,:))));
        buoy70i = cat(1,buoy70i,double(squeeze(mFile.Image(BUOY70_BIN,BUOY70_PULSE,:))));
        adcps = cat(2,adcps,double(squeeze(mFile.Stamp(ADCP_PULSE,:))));
        adcpi = cat(1,adcpi,double(squeeze(mFile.Image(ADCP_BIN,ADCP_PULSE,:))));
        ps2s = cat(2,ps2s,double(squeeze(mFile.Stamp(PS2_PULSE,:))));
        ps2i = cat(1,ps2i,double(squeeze(mFile.Image(PS2_BIN,PS2_PULSE,:))));
    end
    buoy40f = cat(2,buoy40s.',buoy40i);
    buoy70f = cat(2,buoy70s.',buoy70i);
    adcpf = cat(2,adcps.',adcpi);
    ps2f = cat(2,ps2s.',ps2i);
   
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