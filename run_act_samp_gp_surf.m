addpath ~/Dropbox/Current/SFM_nonStat_nonGauss/InfoGeomCode
addpath ~/Dropbox/Matlab/GPML/
startup
dirStruct = dir;
fileStruct = dirStruct(3:end);

N = length(fileStruct)

NSF = zeros(N,1);
varNSF= zeros(N,1);
Err = zeros(N,1);
L = zeros(N,1);
H = zeros(N,1);
varH = zeros(N,1);

Np = 100;
meshAx = [0,1,0,1];
MinTrain = 10;
MaxTrain = 100;

ORDER = 1;

for n=1:N
    fn = fileStruct(n).name;
    disp(fn);
    y = load(fn);
    y = normalis(y,y);
    [NSF(n),varNSF(n)] = nsf_new(y);
    L(n) = length(y);
    [H(n),varH(n)] = negent_hist(y);
    [a,e,k] = arburg(y,ORDER);
    Err(n) = e; %rmse prediction error
    
    if (n >= MinTrain)
        x = [H , NSF]; % the metric space of negent and NSF. Both in [0,1]
        t = Err;
        f = randperm( max(MinTrain,n) );
        
        Ntrain = min(n,MaxTrain); Ntrain = max(MinTrain,Ntrain); % number of examples to train GP with
        xt = x(f(1:Ntrain), :);
        tt = t(f(1:Ntrain));
        [yp,sd,ax] = gp_surface(xt,tt,Np,meshAx);
        %yp = min(yp,1); yp = max(yp,0);
        %yp = (tanh(yp)+1)/2;
        figure(1)
        clf;
        subplot(121)
        pcolor(ax(:,1),ax(:,2),yp);
        shading('interp'); colorbar;
        hold on; plot(xt(:,1),xt(:,2),'w.'); hold off;
        subplot(122)
        pcolor(ax(:,1),ax(:,2),sd);
        shading('interp'); colorbar;
        hold on; plot(xt(:,1),xt(:,2),'w.'); hold off;
        drawnow; pause;
    end;
end;
