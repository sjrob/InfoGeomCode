function [ne , varne] = negent_sr(y);
%[ne , varne] = negent_sr(y);

[sk,varsk] = skew_sr(y);
[k,vark] = kurt_sr(y);

ne = (sk^2)/12 + (k^2)/48;
sd = abs(sk)*sqrt(varsk)/6 + abs(k)*sqrt(vark)/24;
varne = sd^2;

