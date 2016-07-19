%% Write Polar item step data 

folderroot = ('G:\Angus\PolarExport3\');

%rot is used to denote the number in the sequence of the rotation, 
%if it does not exist it is created.
if exist('rot','var') 
    rot = rot+1;
    cd(currentFolder);
else
    rot = 1;
end

% new folder every thousand rotations. Named by first
% timestamp
if (mod(rot,1000) == 1)
    newFolder = [folderroot num2str(LineInfo.TimeStamp(1)) '\'];
    mkdir(newFolder);
    cd(newFolder);
    currentFolder = newFolder;
end

%store rotation data
rot_num = ['rot' num2str(rot)];
save(rot_num, 'PolarImage', 'LineInfo','-v6');



