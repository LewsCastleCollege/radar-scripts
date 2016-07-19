folderstore = 'e:\PolarExport';

folderdir = uigetdir;

folderlist = dir(folderdir);
folderlist = struct2cell(folderlist);
folderlist = folderlist(1,3:end);
fRecord = cell(length(folderlist));
for i=1:length(folderlist)
    fRecord{i,1} = ConcatenatePolarRotations(folderstore, folderdir, folderlist{i});
end
