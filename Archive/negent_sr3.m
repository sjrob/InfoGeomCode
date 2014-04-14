function [ne , varne] = negent_sr3(y);
%[ne , varne] = negent_sr3(y);


ne = mean( log (cosh(y)) );
varne = 1;
