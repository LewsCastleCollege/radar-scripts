% check the timestamp difference within a file

currentFolder = pwd;
    
folderdir = uigetdir;
cd(folderdir);
    
filelist = dir('*.mat');    % get list of mat files
filelist = SortDirFiles(filelist);

diffStore = cell(length(filelist),1);
for i=1:length(filelist)
    mFile = matfile(filelist{i});
    diffStore{i} = DiffInnerTimestamps(mFile.Stamp);
end

f1 = fopen('d:\Angus\MATLAB\InnerTimestamps.txt','w');
fprintf(f1,'Absolute differences between timestamps:\n\n');
for i=1:size(diffStore,1)
    interDiff = diffStore{i,1};
    for j=1:length(interDiff)
        if (interDiff(j) > 2*1e7)
            fprintf(f1,'File %d %s: Entry %d = %18d\n',i,filelist{i},j,interDiff(j));
        end
    end
end
fclose(f1);

cd(currentFolder);
