function [filelist] = ConcatenatePolarRotations(folderstore, folderroot, folder)
% The individual files in a folder of Polar output are grouped into one 
% Matlab file

tic;

newFolder = [folderroot '\' folder];

NUMBER_OF_BINS = 1024;
NUMBER_OF_DIRECTIONS = 4096;
NUMBER_OF_TIME_STAMPS = NUMBER_OF_DIRECTIONS;

currentFolder = pwd;
cd(newFolder);

filelist = dir('*.mat');
filelist = SortDirFiles(filelist);

maxRotations = length(filelist);
maxRotations = 100;
Image = zeros(NUMBER_OF_BINS, NUMBER_OF_DIRECTIONS, maxRotations,'uint16');
Stamp = zeros(NUMBER_OF_TIME_STAMPS, maxRotations,'uint64');

for rotationCount = 1:maxRotations
    load(filelist{rotationCount});
    if (length(LineInfo.TimeStamp) == NUMBER_OF_TIME_STAMPS) % ignore corrupted image
        Image(:,:,rotationCount) = PolarImage;
        Stamp(:,rotationCount) = LineInfo.TimeStamp;
    else
        Stamp(:,rotationCount) = zeros(NUMBER_OF_TIME_STAMPS,1,'uint64');
    end
end

cd(folderstore);
save(folder, 'Image', 'Stamp', '-v7.3');

cd(currentFolder);

toc;

end

