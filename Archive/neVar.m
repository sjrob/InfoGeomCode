function entropyVariance = neVar(timeSeries)
% Version 1.1 
% This function produces a measure of non-Gaussianity.
% Input is a vector of time series data
% Output is Variance of negentropy (Hyvarinen (Roberts & Everson p.81)

    % standardize data
    stdTimeSeries = (timeSeries-mean(timeSeries))/std(timeSeries); %normalised affine xform
    
    %set up the location array
    Nbins = 100;
    xi = linspace(-5, 5, Nbins);
      
    % fit KDE to standardized data
    [kernelDensity,xValues] = ksdensity(stdTimeSeries,xi);
    dx = diff(xValues); dx = dx(1);

    % calculate entropy of standardized data
    differentialEntropy = -sum(kernelDensity.*log(kernelDensity+eps)*dx);
    negEntropy = (1+log(2*pi))/2 - differentialEntropy;
   
    
    % calculate variance (as per Hutchison-Shenton (1974) p.92)
    entropyVariance = sum(kernelDensity.*(log(kernelDensity+eps)).*(log(kernelDensity+eps))-negEntropy^2)/Nbins;
    
end
