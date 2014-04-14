function negEntropy = ng5(timeSeries)
% Version 3.1 (SR + AA)
% This function produces a measure of non-Gaussianity.
% Input is a vector of time series data
% Output is negentropy (Hyvarinen (Roberts & Everson p.81)

    % standardize data
   % stdTimeSeries = (timeSeries-mean(timeSeries))/std(timeSeries); %normalised affine xform
    stdTimeSeries = timeSeries;
    sigma = std(timeSeries);

    %set up the location array
    Nbins = 200;
    sd_lims = 15;    
    xi = linspace(-sd_lims, sd_lims, Nbins);
      
    % fit KDE to standardized data
    binWidth = 2*sd_lims / Nbins;
    [kernelDensity,xValues] = ksdensity(stdTimeSeries,xi);
    dx = diff(xValues); dx = dx(1);

    % calculate entropy of standardized data
    differentialEntropy = -sum(kernelDensity.*log(kernelDensity+eps)*dx);
    %negEntropy = log(sigma * sqrt(2 * pi * exp(1))) - differentialEntropy;
    negEntropy = -differentialEntropy;
    
end
