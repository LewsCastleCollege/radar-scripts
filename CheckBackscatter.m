function [report] = CheckBackscatter(backscatter)
% Check for corrupted and missing data

corr = ones(size(backscatter,1),1);
for i=1:size(backscatter,1)
    if backscatter(i,1) == 0
        corr(i) = 0;
    end
end
report.corrupt = corr;
report.missing = abs(diff(double(backscatter(:,1))));

end

