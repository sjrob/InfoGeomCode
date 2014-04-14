HN = 0.5*(1+log(2*pi));
y1 = randn(100000,1);
y2 = rand(100000,1);

for n=1:100,
    r(n)=rand; y = y1*r(n) + (1-r(n))*y2; y = normalis(y,y);
    [p,a] = pdf(y,1000);p=p/sum(p);
    H(n) =  -sum(p .* log(p+eps));
    [k(n),vk(n)] = kurt_sr(y);
    [ne2(n),vne(n)] = negent_sr2(y);
    [ne3(n),vne(n)] = negent_sr3(y);
    [ne(n),vne(n)] = negent_sr(y);
end;