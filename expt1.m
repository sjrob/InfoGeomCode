addpath /homes/47/parg/nsdata/Data/TimeSeries


ORDER = 1;
cd Web_Time_Series_Files_7/
read_ts
save ~/Desktop/wts7_ar1.mat
cd ../


ORDER = 20;
cd Web_Time_Series_Files_7/
read_ts
save ~/Desktop/wts7_ar20.mat
cd ../






