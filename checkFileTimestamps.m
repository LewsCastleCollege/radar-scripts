% check the differences between the last time stamp in a file and the first
% time stamp of the next file

currentFolder = pwd;
    
folderdir = uigetdir;
cd(folderdir);
    
filelist = dir('*.mat');    % get list of mat files
filelist = SortDirFiles(filelist);

slindex = 1;
stamplist = ones(length(filelist)*2,1);
for i=1:length(filelist)    
    mFile = matfile(filelist{i});
    stamplist(slindex) = mFile.Stamp(1,1);
    stamplist(slindex+1) = mFile.Stamp(end,end);
    slindex = slindex+2;
end
d = diff(double(stamplist));
dd = d(2:2:end);

f1 = fopen('d:\Angus\MATLAB\FileTimestamps.txt','w');
fprintf(f1,'Absolute differences between timestamps:\n\n');
for i=1:length(dd)
    fprintf(f1,'Last timestamp of file %s and first timestamp of file %s = %18d\n' ...
    ,filelist{i},filelist{i+1},dd(i));
end
fclose(f1);

cd(currentFolder);
