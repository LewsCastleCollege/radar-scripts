folderstore = 'E:\PointBackscatter';

folderdir = uigetdir;

tic;
startTime = datetime(2016,03,23,14,0,0);
endTime = datetime(2016,03,25,15,00,0);
timePeriods = startTime:minutes(30):endTime;
for i=1:length(timePeriods)-1
    startTimeString = datestr(timePeriods(i),'dd/mm/yyyy HH:MM:ss');
    endTimeString = datestr(timePeriods(i+1),'dd/mm/yyyy HH:MM:ss');
    [b40, b70, adcp, ps2, loc] = GetBackscatter(folderdir, startTimeString, endTimeString);
    report = CheckBackscatter(b40);
    filename = [folderstore '\' datestr(timePeriods(i),'yyyymmdd_HHMM')];
    save(filename,'b40','b70','adcp','ps2','loc','report','-v7.3');
end
toc;