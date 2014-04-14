Fs = 1000; % Sampling frequency
T = 1/Fs; % Sample time
L = 1000; % Length of signal
t = (0:L-1)*T; % Time vector
x = 2.1*sin(2*pi*83*t) + .8*sin(2*pi*137*t);
y = x + nLevel*randn(size(t));
y = y-mean(y); y = y/std(y);

nonFlat = nsf2(y);
%psd(y);

return;

NFFT = 2^nextpow2(L);
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
plot(f,2*abs(Y(1:NFFT/2+1)));
s=2*abs(Y(1:NFFT/2+1));
logs=log(s);
gm=exp(sum(logs)/L);
am=mean(s);
WE=gm/am






