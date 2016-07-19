function [minDiff, maxDiff, minIndex, maxIndex] = DiffTimestampRange(tStamp)
% Calculate maximum and minimum time differences and their 
% indexes

DIFF_CUTOFF = 14000000;

minDiff = 100000;
maxDiff = 1;
for j=1:size(tStamp,2)    % for each column
    for i=1:size(tStamp,1)
        if (~((i == 1) && (j == 1))) %ignore first value
            if (i == 1)
                diff = abs(double(tStamp(i,j)) - double(tStamp(size(tStamp),j-1)));
            else
                diff = abs(double(tStamp(i,j)) - double(tStamp(i-1,j)));
            end
            if ((diff > maxDiff) & (diff < DIFF_CUTOFF))
                maxDiff = diff;
                maxIndex = [i,j];
            end
            if ((diff ~= 0) & (diff < minDiff))
                minDiff = diff;
                minIndex = [i,j];
            end
        end
    end
end

end

