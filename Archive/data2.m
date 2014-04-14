% Calculate information geometry statistics of dataset

close all;

format long;

% Test dataset

Fs = 1000; % Sampling frequency
T = 1/Fs; % Sample time
L = 3000; % Length of signal
t = (0:L-1)'*T; % Time vector
nLevel = 0.1; %noise level
Nsig = randi(10)
x = zeros(size(t));
for n=1:Nsig,
    x = x + sin(2*pi*rand*300*t);
    %x = 0.5sin(2*pi*83*t) + .5*sin(2*pi*137*t);
end;
x = normalis(x,x);
y = x + nLevel*randn(size(t));

trials = 20;
windowLength = 500;

%figure(1);plot (t,y);

%spectralDensity = psd(spectrum.welch,y,'Fs',Fs);
%figure(2); plot(spectralDensity);


fprintf('trials=%4.0f         ',trials)

% calculate Nongaussianity 
%NG = ng_sr(y);
[NG,varNG] = kurt_sr(y);
fprintf('NG= %15.4f  ',NG)

%and its variance
fprintf('Var(NG)= %8.4f  ',varNG)

% calculate Non spectral flatness
[NSF,varNSF] = nsf_new(y);
fprintf('NSF= %14.4f  ',NSF)

% and its variance
fprintf('Var(NSF)= %8.4f\n',varNSF)

    
%figure;
plot(NG,NSF,'o','MarkerFaceColor','r','MarkerSize',20);
hold on
plotellipse([NG,NSF] , [varNG 0 ; 0 varNSF], 'r');
       
            
for tests=1:1,
	color = rand(1,3);
      
            
	% bootstrap
	clear bsNG bsNSF

	for trial=1:trials,
	    windowStart = randi(L-windowLength+1);
	    window = y(windowStart:windowStart+windowLength-1);
%	    bsNG(trial) = ng_sr(window);
	    [bsNG(trial),var_bsNG(trial)] = kurt_sr(window);
	    [bsNSF(trial), var_bsNSF(trial)] = nsf_new(window);
	    plot(bsNG,bsNSF,'o','MarkerFaceColor',color);
        plotellipse([bsNG(trial), bsNSF(trial)] , [var_bsNG(trial) 0 ; 0 var_bsNSF(trial)], 'c');
      	drawnow;
    end;

	%fprintf('Window=(%4.0f,%4.0f)  ',windowStart,windowStart+windowLength-1)

	% calculate sample mean Nongaussianity 
    sm_bsNG = mean(bsNG);
	fprintf('mean(bsNG)= %6.4f  ', sm_bsNG)

	%and its sample variance
    sv_bsNG = var(bsNG);
    vNG = mean(var_bsNG) + var(bsNG);
	fprintf('SVar(bsNG)= %6.4f  ',sv_bsNG)
    fprintf('Var(bsNG)= %6.4f  ', vNG)
    
	
	% calculate sample mean Non spectral flatness
    sm_bsNSF = mean(bsNSF);
	fprintf('mean(bsNSF)= %6.4f  ', sm_bsNSF)
	
	% and its sample variance
    sv_bsNSF = var(bsNSF);
    vNSF = mean(var_bsNSF) + var(bsNSF);
	fprintf('SVar(bsNSF)= %6.4f\n',sv_bsNSF)
    fprintf('Var(bsNSF)= %6.4f\n',vNSF)

	
    %plot these
    plot(mean(bsNG),mean(bsNSF),'o','MarkerFaceColor','r','MarkerSize',10);
    plotellipse([sm_bsNG, sm_bsNSF] , [sv_bsNG 0 ; 0 sv_bsNSF], 'g'); %sample cov
    plotellipse([sm_bsNG, sm_bsNSF] , [vNG 0 ; 0 vNSF], 'r'); %inferred cov    
	drawnow;

end

hold off;
format compact

    
