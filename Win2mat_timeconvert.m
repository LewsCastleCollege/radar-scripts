function [ mtime ] = Win2mat_timeconvert( in_tstep )
%win2matltimeconvert converts windows time stamp to matlab value.
secs = vpa(in_tstep,18)*1e-9*100;
mtime = datetime(double(secs),'ConvertFrom','epochtime','Epoch',...
    '1-Jan-1601','Format','dd-MMM-yyyy HH:mm:ss.SSSSSSS');

end

