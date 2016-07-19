% check the timestamp ranges excluding outliers

currentFolder = pwd;
    
folderdir = uigetdir;
cd(folderdir);
    
filelist = dir('*.mat');    % get list of mat files
filelist = SortDirFiles(filelist);

minDiff = zeros(length(filelist));
maxDiff = zeros(length(filelist));
minIndex = zeros(length(filelist),2);
maxIndex = zeros(length(filelist),2);
for i=1:length(filelist)
    mFile = matfile(filelist{i});
    [minD, maxD, minI, maxI] = DiffTimestampRange(mFile.Stamp);
    minIndex(i,1)=minI(1);
    minIndex(i,2)=minI(2);
    maxIndex(i,1)=maxI(1);
    maxIndex(i,2)=maxI(2);
end

cd(currentFolder);
