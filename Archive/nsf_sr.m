function [weMean,weVar] = nsf_sr(timeSeries,Fs)
% Version 3.1 (SR)
% This function produces a measure of non-spectral flatness. Input is
% a vector of time series data. Output is Wiener Entropy.


% standardize data
stdTimeSeries = (timeSeries-mean(timeSeries))/std(timeSeries); %normalised affine xform

nfft = 512;
%S = psd(stdTimeSeries);
S = psd(spectrum.welch,stdTimeSeries,'Fs',Fs,'NFFT',nfft,'ConfLevel',0.841,'SpectrumType','Onesided'); %0.841 is the 1sd quantile

%Nfft = 512;
% [P,F,Pul] = pwelch(stdTimeSeries,[],[],Nfft,Fs,'ConfidenceLevel',0.841);
% S.data=P;
% S.ConfInterval = Pul;
 
% weMean = wienEnt(S.data);
% low = wienEnt(S.ConfInterval(:,1));
% upp = wienEnt(S.ConfInterval(:,2));
% sd = abs(upp-low)/2;
% weVar = sd^2 + eps;

%P = log(S.data + eps);
P = S.data;
%[weMean,weVar] = kurt_sr(P);
mom = dist2mom([1:length(P)]' , P);
%weMean = mom.kr;
%weVar = mom.vark;
weMean = mom.ent;
weVar = 0.01;


function wE = wienEnt(S);

S = S/sum(S); %normalise to unit power
%geometricMean = exp( mean(log(S+eps)));
%weinerEntropy = geomean(S) / mean(S);
%wE = geometricMean / mean(S);
geometricMean = mean(log(S+eps));
wE = geometricMean - log(mean(S)+eps);
