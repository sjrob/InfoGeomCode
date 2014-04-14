function weinerEntropy = nsf(timeSeries)
% Version 1.1 20130204
% This function produces a measure of non-spectral flatness. Input is
% a vector of time series data. Output is Weiner Entropy.
%     fourierLength = 2 ^ nextpow2(length(timeSeries));
%     fourierSeries = fft(timeSeries,fourierLength) / length(timeSeries);
%     fourierSeries = 2*abs(fourierSeries(1:fourierLength / 2 + 1));
%     geometricMean = exp(sum(log(fourierSeries)) / length(timeSeries));

    warning off;
    S = psd(timeSeries);
    geometricMean = exp( mean(log(S+eps)));
    arithmeticMean = mean(S);
    weinerEntropy = geometricMean / arithmeticMean;
    warning on;
end
