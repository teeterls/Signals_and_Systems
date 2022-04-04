function [X,f] = dibujaTdF(x,dt)

% function dibujaTdF(x,dt)
% Dibuja la Transformada de Fourier de la señal x.
% x - Señal de entrada
% dt - Resolución de la señal de entrada

if ~isempty(find(isnan(x)==1))
    error('Cuidado! La variable x tiene algún valor que es infinito (Nan)');
end

L=length(x);
Nfft=2^ceil(log2(5*L)); % Sobremuestreo para dar aspecto cotinuo
X=fft(x,Nfft);
X = X(1:Nfft/2)/(L); % Solo espectro positivo
f = linspace(0,.5,Nfft/2)/dt;
if (f(end)>10e3)
    khz = true;
else
    khz = false;
end

if nargout == 0
    figure
    if khz
        plot(f*1e-3,abs(X))
        xlabel('Frecuencia [kHz]'),grid
    else
        plot(f,abs(X))
        xlabel('Frecuencia [Hz]'),grid
    end
    title('Transformada de Fourier')
    ylabel('|X(f)|');
end

