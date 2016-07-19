folderstore = 'E:\PointBackscatter';

folderdir = uigetdir;

startTime = datetime(2016,03,24,05,30,0);
endTime = datetime(2016,03,24,06,00,0);
startTimeString = datestr(startTime,'dd/mm/yyyy HH:MM:ss');
endTimeString = datestr(endTime,'dd/mm/yyyy HH:MM:ss');

GetBackscatter2(folderdir, startTimeString, endTimeString);

