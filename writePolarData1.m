%% Write Polar item step data 

%folderroot = ('E:\PolarExport\');
folderroot = ('E:\PolarExport4\');

%n is used to denote the number in the sequence of the rotation, if it does
%not exist it is created.
if exist('n','var') 
    n = n+1;
    cd(currentFolder);
else
    n = 1;
end

if (mod(n,1000) == 1)
    newFolder = [folderroot num2str(LineInfo.TimeStamp(1)) '\'];
    mkdir(newFolder);
    cd(newFolder);
    currentFolder = newFolder;
end

if isempty(LineInfo(1,1))== 0  
    tstep_num = ['tstep' num2str(n)];
    save(tstep_num, 'PolarImage', 'LineInfo','-v6');
end


