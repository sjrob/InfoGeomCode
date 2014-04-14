function mom = dist2mom(x, distn);
%mom = dist2mom(x, distn);
%
%produces set of moments, 1st to 3rd, from emprical distn / histogram
%x is array defining locations of each hist element in distn

% now check for -ve elements, Nan and Inf and sizes match
if (sum(distn<0) > 0)
    error('Negative numbers in distn found');
elseif (sum(isnan(distn)) > 0)
    error('Nan in distn found');
elseif (sum(isinf(distn)) > 0)
    error('Inf in distn found');
elseif (length(x) ~= length(distn))
    error('x and distn must be same size');
end;

p = distn / sum(distn); %make sure it adds to unity
n = length(distn);

%now create 1st and second moments
mn = sum(x .* p);
vr = (n/(n-1)) * sum(x.^2 .* p) - mn^2;
sd = sqrt(vr);

%normalised array used for 3rd, 4th central moments
nx = (x-mn)/sd;
sk = sum(nx.^3 .* p);
kr = sum(nx.^4 .* p);
preMult = (n+1)*n / ( (n-1)*(n-2)*(n-3) );
postMult = (n-1)^2 / ( (n-2)*(n-3) );
kr = preMult*kr - 3*postMult;
vark = 4*(6*n*(n-1)*(n-1)*(n+1)) / ( (n-3)*(n-2)*(n+1)*(n+3)*(n+5) );

%output
mom.mn = mn;
mom.vr = vr;
mom.sk = sk;
mom.kr = kr;
mom.vark = vark;
mom.ent = -sum(p .* log2(p+eps));