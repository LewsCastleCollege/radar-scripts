filelist = dir('e:\PolarExport\*.mat');

filelist = struct2cell(filelist); 
filelist = sortrows(filelist',1);
filelist = filelist(:,1);

tnum = strrep(filelist,'.mat','');
tnum = str2double(tnum);
tList = win2mat_timeconvert(tnum);

f1 = fopen('d:\Angus\MATLAB\filelist.txt','w');
for i=1:length(filelist)
    fprintf(f1,'%s %s\n',filelist{i},datestr(tList(i)));
end
fclose(f1);
