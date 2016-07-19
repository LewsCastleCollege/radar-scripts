function [filelist] = SortDirFiles(filelist)
%ensure file list is in correct order

filelist = struct2cell(filelist); 
filelist = filelist';
filelist = filelist(:,1);

tList = filelist;
tTemp = strrep(tList,'tstep','');
tTemp = strrep(tTemp,'rot','');
tTemp = strrep(tTemp,'.mat','');
tTemp = str2double(tTemp);
tList = [tList num2cell(tTemp)];
tList = sortrows(tList, 2);
filelist = tList(:,1);

end

