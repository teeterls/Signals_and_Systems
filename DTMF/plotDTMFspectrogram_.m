function plotDTMFspectrogram(x)

Nx = length(x);
nsc = floor(Nx/4.5);
nsc = 1000;
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
Fs = 44100;
figure
spectrogram(x,hamming(nsc),nov,nff,Fs);