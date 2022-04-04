function senyal = generaDTMF(numeros,PLOT)
% function generaDTMF(numeros)
% Funcion que genera una secuencia de tonos DTMF según el vector de números
% enteros que se pasa por parámetro.
%
% Cada componente del vector de entrada ha de ser de un único dígito mayor
% o igual a 0
%
% INPUT:
%   - numeros: vector de numeros a codificar con DTMF
%   - PLOT: booleano para indicar si se harán las representaciones de la secuencia generada
%
% OUTPUT:
%   - senyal: señal DTMF codificada
%numero 6428

if nargin == 0
    numeros = [0 1 2 3]; 
    PLOT = true; 
end

matrixRef = [['1','2','3','A'];['4','5','6','B'];['7','8','9','C'];['*','0','#','D']];
fcol = [1209 ,1336 ,1477 ,1633 ];
frow =[697,770,852,941];

if ~isempty(find(numeros>9 | numeros <0))
    error('Las componentes del vector han de ser de un solo dígito mayor o igual a cero');
else
    
    fTones = nan(length(numeros),2); % Pre-allocation
    for iter = 1:length(numeros)
        [fil,col]=find(matrixRef==num2str(numeros(iter)));
        fTones(iter,1) = frow(fil);
        fTones(iter,2) = fcol(col);
    end
    
    toneDuration = .25;
    Fs = 8000;
    Ts = 1/Fs;
    t = 0:Ts:toneDuration*1.2*length(numeros);
    senyal = zeros(1,length(t));
    
    % relleno el vector de x
    for iter = 1:size(fTones,1)
        ind = find((t>toneDuration/4+(toneDuration*(iter-1))) & (t<toneDuration*iter));
        tukeyWin = tukeywin(length(ind),.15); % Tukey window con transicion muy corta para que sea un sonido mas natural
        senyal(ind) = .5.*(sin(2*pi*t(ind)*fTones(iter,1))+sin(2*pi*t(ind)*fTones(iter,2))) .* tukeyWin.';
    end
    
    if PLOT
        figure
        plot(t,senyal)
        xlabel('Tiempo [s]')
        title('Representación temporal de la señal');
        NFFT = length(senyal);
        f = linspace(-.5,.5,NFFT)*Fs;
        X = fft(senyal,NFFT);
        figure
        plot(f*1e-3,abs(fftshift(X)));
        xlabel('Frecuencia [kHz]')
        title('Representación en frecuencia de la señal');
        sound(senyal/max(senyal),Fs)
        
        plotDTMFspectrogram(senyal)
        autoArrangeFigures
    end
end




function plotDTMFspectrogram(x)

Nx = length(x);
nsc = floor(Nx/4.5);
nsc = 1000;
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc))*10;
Fs = 8000;
figure
spectrogram(x,hamming(nsc),nov,nff,Fs);