function [nonSpectralFlatness,nsfVariance] = nsf4(timeSeries)
% Version 4.3 20130630
% This function produces a measure of non-spectral flatness. Input is
% a vector of time series data. Output is Asif's non-spectral flatness.

samplingFrequency = 1000;   % change later using fourierlength.m

spectralDensity = psd(spectrum.welch,timeSeries,'Fs',samplingFrequency);
timeSeriesSpectrum = spectralDensity.Data;

n = length(timeSeriesSpectrum);

entropy = -sum(timeSeriesSpectrum.*log(timeSeriesSpectrum));
nonSpectralFlatness = 1 + exp(entropy/(sum(timeSeriesSpectrum)*log(n)));

squaredEntropy = sum(timeSeriesSpectrum.*log(timeSeriesSpectrum).*log(timeSeriesSpectrum));

nsfVariance = abs((1/n) * (squaredEntropy - entropy^2));


end
