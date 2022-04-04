function [t,demod_final,demodulada] = demodulaAm(y_mod,fs,fc,filtro)

t = linspace(0,(1/fs)*length(y_mod),length(y_mod));
coseno = cos(2*pi*fc*t);
demodulada = y_mod.*coseno;
demod_final = filter(filtro.Numerator,1,demodulada);
end

