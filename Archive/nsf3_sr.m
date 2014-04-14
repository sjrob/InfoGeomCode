function weinerEntropy = nsf_sr(timeSeries)
% Version 2.1 (SR)
% This function produces a measure of non-spectral flatness. Input is
% a vector of time series data. Output is Weiner Entropy.


timeSeries = timeSeries-mean(timeSeries);
timeSeries = timeSeries/std(timeSeries);

%warning off;
h = spectrum.welch;
hS = psd(h,timeSeries,'Fs',1,'NFFT',128);
S = hS.data;
geometricMean = exp( mean(log(S+eps)));
arithmeticMean = mean(S);
weinerEntropy = geometricMean / arithmeticMean;

%warning on;
