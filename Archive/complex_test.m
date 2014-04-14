% Calculate information geometry statistics of dataset


% Test dataset

Fs = 1; % Sampling frequency
T = 1/Fs; % Sample time
L = 1000; % Length of signal
t = (0:L-1)'*T; % Time vector
nLevel = 0.0; %noise level
x = zeros(size(t));
nse = nLevel*randn(size(t));
Nsig = 10;

for n = 1:Nsig,
    x = x + sin(2*pi*rand*(Fs/4)*t);
    %x = 0.5sin(2*pi*83*t) + .5*sin(2*pi*137*t);
    x = normalis(x,x);
    y = x + nse;
    [NG(n),varNG(n)] = kurt_sr(y);
    %[NG(n),varNG(n)] = ng3(y);
    [NSF(n),varNSF(n)] = nsf_new(y);
    %[NSF(n),varNSF(n)] = nsf4(y);
end;    

hold on;

for n=1:Nsig,
    text(NG(n),NSF(n),sprintf('%d',n));
    plotellipse([NG(n),NSF(n)],[varNG(n) 0; 0 varNSF(n)],'b');
end;

hold off