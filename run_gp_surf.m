x = [H , NSF]; % the metric space of negent and NSF. Both in [0,1]
f = randperm( length(x) );
%t = log10(T)-log10(L);
t = Err;

Ntrain = 500; % number of examples to train GP with
Np = 100;
meshAx = [0,1,0,1];
xt = x(f(1:Ntrain), :);
tt = t(f(1:Ntrain));
[yp,sd,ax] = gp_surface(xt,tt,Np,meshAx);
yp = min(yp,1); yp = max(yp,0);
%yp = (tanh(yp)+1)/2;
figure(1)
pcolor(ax(:,1),ax(:,2),yp);
shading('interp'); colorbar;
figure(2)
pcolor(ax(:,1),ax(:,2),sd);
shading('interp'); colorbar;

% now look at corrn on hold out data
[yp,sd] = my_gpml(x(f(1:Ntrain),:),t(f(1:Ntrain)),x(f(Ntrain+1:end),:), [1 1 0.1]);
yp = min(yp,1); yp = max(yp,0);
corrcoef(yp,t(f(Ntrain+1:end)))
figure(3);
plot(t(f(Ntrain+1:end)),yp,'.');
%axis([0 1 0 1]);
