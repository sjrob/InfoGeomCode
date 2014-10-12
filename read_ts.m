addpath ~/Dropbox/Current/SFM_nonStat_nonGauss/InfoGeomCode
dirStruct = dir;
fileStruct = dirStruct(3:end);

N = length(fileStruct)

%NG = zeros(N,1);
%varNG= zeros(N,1);
NSF = zeros(N,1);
varNSF= zeros(N,1);
%SK = zeros(N,1);
%varSK= zeros(N,1);
Err = zeros(N,1);
L = zeros(N,1);
H = zeros(N,1);
varH = zeros(N,1);
%ne2 = zeros(N,1);
%ne3 = zeros(N,1);
%NG5 = zeros(N,1);

ORDER =1;

for n=1:N
    fn = fileStruct(n).name;
    disp(fn);
    y = load(fn);
    y = normalis(y,y);
    %[NG(n),varNG(n)] = kurt_sr(y);
    %[SK(n),varSK(n)] = skew_sr(y);
    [NSF(n),varNSF(n)] = nsf_new(y);
    L(n) = length(y);
    [H(n),varH(n)] = negent_hist(y);
    %[ne2(n),vne] = negent_sr2(y);
    %[ne3(n),vne] = negent_sr3(y);
    %[ne(n),vne] = negent_sr(y);
    %NG5(n) = ng5(y);
    [a,e,k] = arburg(y,ORDER);
    Err(n) = e; %rmse prediction error
end;

