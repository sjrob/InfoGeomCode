function negEntropy = ng_sr(timeSeries)
% Version 3.1 (SR)
% This function produces a measure of non-Gaussianity.
% Input is a vector of time series data
% Output is negentropy (Hyvarinen (Roberts & Everson p.81)

    % standardize data
    stdTimeSeries = (timeSeries-mean(timeSeries))/std(timeSeries); %normalised affine xform
    
    %set up the location array
    Nbins = 5;
    sd_lims = 2;    
    xi = linspace(-sd_lims, sd_lims, Nbins);
      
    % fit KDE to standardized data
    binWidth = 2*sd_lims / Nbins;
    [kernelDensity,xValues] = ksdensity(stdTimeSeries,xi);
    dx = diff(xValues); dx = dx(1);

    % calculate entropy of standardized data
    differentialEntropy = -sum(kernelDensity.*log(kernelDensity+eps)*dx);
    negEntropy = (1+log(2*pi))/2 - differentialEntropy;
end
