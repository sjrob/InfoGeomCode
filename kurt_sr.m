function [k,vark] = kurt_sr(y);
%[k,vark] = kurt_sr(y);

n = length(y);
y = (y - mean(y))/std(y);  %normalise the data
%k = kurtosis(y) - 3;
%k = mean(y.^4) - 3; %nice and easy as var(y)=1 and mean(y)=0
if (n < 4)
    k = nan
    vark = nan;
else
    preMult = (n+1)*n / ( (n-1)*(n-2)*(n-3) );
    postMult = (n-1)^2 / ( (n-2)*(n-3) );
    k = sum(y.^4); %as var=1 and mean=0 for y
    k = preMult*k - 3*postMult;
    vark = 4*(6*n*(n-1)*(n-1)*(n+1)) / ( (n-3)*(n-2)*(n+1)*(n+3)*(n+5) );
    %vark = 24/n;
end;
