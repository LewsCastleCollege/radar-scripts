folderstoreE = 'd:\PolarExportExtra\131032187476619238';
folderstoreEE = 'd:\PolarExportExtraExtra\131032187476619238';

currentFolder = pwd;

cd(folderstoreE);
filelistE = dir('*.mat');
filelistE = SortDirFiles(filelistE);

cd(folderstoreEE);
filelistEE = dir('*.mat');
filelistEE = SortDirFiles(filelistEE);

for i=1:length(filelistE)
    cd(folderstoreE);
    load(filelistE{i});
    se=LineInfo.TimeStamp;
    cd(folderstoreEE);
    load(filelistEE{i});
    see=LineInfo.TimeStamp;
    if (isequal(se,see) == 0)
        disp(['Stamp ' num2str(i) ' error']);
     %   break;
    end
end

cd(currentFolder);
