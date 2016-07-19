function [pulse, bin, d, a] = GetPulseBin(SensorEasting, SensorNorthing)
% Get the pulse and bin radar locations based on sensor location

RadarEasting = 619035.9769;
RadarNorthing = 6414833.0174;

NUMBER_PULSES = 4096;
NUMBER_BINS = 1024;
RANGE = 3070;
ANGLE_OFFSET = 270;

d = sqrt((SensorEasting - RadarEasting)^2+(SensorNorthing - RadarNorthing)^2);
a = abs(radtodeg(atan((SensorNorthing - RadarNorthing)/(SensorEasting - RadarEasting))));

a = a + ANGLE_OFFSET;

pulse = floor(a/(360/NUMBER_PULSES));
bin = floor(d/(RANGE/NUMBER_BINS));

end


