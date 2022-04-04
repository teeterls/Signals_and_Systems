function [t,x,xAM] = modulaAM(fm,mu,fs,fc,AC)
m = mu/100;
N=60*1/fm;
ts=1/fs;
t = 0:ts:N;
x=cos(2*pi*fm*t);
xAM=AC*((1+m*x).*cos(2*pi*fc*t));
end

