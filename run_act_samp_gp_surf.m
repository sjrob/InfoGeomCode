addpath ~/Dropbox/Current/SFM_nonStat_nonGauss/InfoGeomCode
addpath ~/Dropbox/Matlab/GPML/
startup

load act_samp_data

Np = 100;
meshAx = [0,1,0,1];
MinTrain = 5;
N = 200;
MaxTrain = MinTrain + N;
hps =  [10 1 1];
sampFlag = zeros(length(X),1);

f = randperm(length(X));
X = X(f,:); T = T(f);

x = X(1:MinTrain,:);
t = T(1:MinTrain);

for n = MinTrain:N
        f = randperm( max(MinTrain,n) );
        Ntrain = min(n,MaxTrain); Ntrain = max(MinTrain,Ntrain); % number of examples to train GP with
        xt = x(f(1:Ntrain), :);
        tt = t(f(1:Ntrain));
        [yp,sd,ax] = gp_surface(xt,tt,Np,meshAx,hps);
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
        maxUnc = max(max(sd));
        [ix,iy] = find(sd == maxUnc);
        f = randperm(length(ix)); %choose a random max uncertainty point.
        ix = ix(f(1)); iy = iy(f(1));
        maxUncX = [ax(ix,1),ax(iy,2)];
        distToX = sum(((repmat(maxUncX,length(X),1)-X).^2)')';
        [a,minDistElement] = min(distToX);
        if (sampFlag(minDistElement) == 1)
            disp('Already selected: choosing random data set');
            f = randperm(length(X));
            minDistElement = f(1);
        else
            disp('Selecting new data set using active sampling');
            sampFlag(minDistElement) = 1;
        end;
        nextX = X(minDistElement,:);
        nextT = T(minDistElement);
        x = [x ; nextX];
        t = [t ; nextT];
end;
