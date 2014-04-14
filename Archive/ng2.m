function negEntropy2 = ng2(timeSeries)
% Version 1.2 20130131
% This function produces a measure of non-Gaussianity.
% Input is a vector of time series data
% Output is negentropy (Hyvarinen (Roberts & Everson p.81)


stdTimeSeries = (timeSeries-mean(timeSeries))/std(timeSeries);
binnedData = hist(stdTimeSeries, min(stdTimeSeries):max(stdTimeSeries));
probabilityDistribution = binnedData/sum(binnedData);
entropy2 = -sum(probabilityDistribution.*log(probabilityDistribution));
negEntropy2 = .5*log(2*pi*exp(1))-entropy2; 


end
