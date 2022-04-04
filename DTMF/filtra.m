function senyal_filtrada = filtra(x,fc,Fs,PLOT_FREQ_RESPONSE)

% function senyal_filtrada = filtra(x,fc,Fs)
% Funcion que devuelve la señal de entrada filtrada de acuerdo a la o las
% frecuencias de corte pasadas por parámetro.
%
% INPUT:
%   - x: señal a filtrar
%   - fc: frecuencia o frecuencias de corte. Si se introduce una única
%   frecuencia se sobreentiende que se trata de un filtro paso bajo con
%   dicha frecuencia de corte. Si fc es un vector de dos componentes, se
%   sobreentiende que se trat de un filtro paso banda donde la frecuncia
%   de corte inferior y superior son la primera y segunda componente del
%   vector fc
%   - Fs: frecuencia de muestreo de la señal de entrada
%   - PLOT_FREQ_RESPONSE: variable boolena que indica si se quiere una
%   representación gráfica de la respuesta en frecuencia del filtro.
%
% OUTPUT:
%   - senyal_filtrada: Señal filtrada

if nargin <4
    PLOT_FREQ_RESPONSE = false;
end
orden = 500;
fcn = fc/Fs;
if length(fc) == 1
    isLPF = true;
elseif length(fc) == 2
    isLPF = false;
else
    error('El vector de frecuencias de corte ha de ser de una (para LPF) o dos (para BPF) componentes');
end

if isLPF
    h = fir1(orden,fcn*2,'low');
else
    h = fir1(orden,fcn*2,'bandpass');
end

senyal_filtrada = filter(h,1,x);

    
if PLOT_FREQ_RESPONSE
    figure
    [respFreq,w] = freqz(h,1,1e4);
    plot(w/pi/2*Fs,10*log10(abs(respFreq)))
    
    
    if isLPF
        titleStr = ['FPBj f_{corte} = ' , num2str(fc(1)), '.' ];
    else
        titleStr = ['FPBd fc_{corte} = [' , num2str(fc(1)), ', ',num2str(fc(2)) , ']. Frec central = ', num2str(fc(1)+diff(fc)/2)];
        
    end
    
    title(titleStr)
end
    