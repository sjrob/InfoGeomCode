function [sk,varsk] = skew_sr(y);
%[sk,varsk] = skew_sr(y);

% line added by Asif to test forking

n = length(y);
y = (y - mean(y))/std(y);  %normalise the data

if (n < 3)
    k = nan
    varsk = nan;
else
    preMult = sqrt(n*(n-1)) / (n-2);
    sk = mean(y.^3); %as var=1 and mean=0 for y
    sk = preMult*sk;
    varsk = 6*n*(n-1) / ( (n-2)*(n+1)*(n+3) );
    %varsk = 6/n;
end;
