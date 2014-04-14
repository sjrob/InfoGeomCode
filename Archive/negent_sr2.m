function [ne , varne] = negent_srq(y);
%[ne , varne] = negent_srq(y);


ne = mean( -exp(-y.^2) );
varne = 1;
