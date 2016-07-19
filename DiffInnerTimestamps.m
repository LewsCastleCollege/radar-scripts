function [dStamp] = DiffInnerTimestamps(tStamp)
% Differences betwen timestamps

Stamp0 = ones(size(tStamp,2),1);
for i=1:size(tStamp,2)    % for each column
    Stamp0(i) = tStamp(1,i);
end
dStamp = abs(diff(double(Stamp0)));
end

