function plotSELCALLspectrogram(x)

Nx = length(x);
nsc = 2000;
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
fs = 44100;
figure
spectrogram(x(:,1),hamming(nsc),nov,nff,fs);