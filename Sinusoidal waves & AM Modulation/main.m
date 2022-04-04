%% Pr�ctica 2
%
% Grupo 11
%
% Nombre_1 Teresa Gonz�lez Gac�a
%
% Nombre_2 Miguel Oleo Blanco

close all; format compact; clear all

%% Ejercicio 1
% La funci�n my_coseno toma los siguientes par�metros de entrada:
% 
% N: n�mero de muestras a representar
% 
% Ts: paso o periodo de muestreo (en s)
%
% f: la frecuencia del coseno (en Hz)
%
% phi: la fase del coseno (en radianes)
%
% A: la amplitud del coseno (en V) 
% 
% my_coseno devuelve:
%
% t: el vector de referencia de tiempos;
%
% y: el valor del coseno para dicho vector.
%
% La funci�n debe probarse para N=1000, Ts=10 microsegundos, f=1 KHz, 
% phi=0 rad y A= 1 V (ojo con las unidades), por lo que la llamada ser� la siguiente:
%
% [t, y] = my_coseno(N, Ts, f, phi, A);
%
% Debe representar la funci�n con el eje de tiempos etiquetado en milisegundos

%Configuraci�n de los par�metros de entrada seg�n se indica en el enunciado
N=1000;
Ts=10*10^-6;
f=1000;
phi=0;
A=1;

% Llamada a my_coseno

[y,t] = my_coseno(N, Ts, f, phi, A);

% Representaci�n temporal
t=t*1000; %Lo multiplicamos para dajarlo en ms;
figure;
plot(t,y); %configure la llamada a plot adecuadamente
title('Coseno');
xlabel('t (ms)');
ylabel('V (V)');
grid on

%% 
% Incluya aqu� su an�lisis
% �Cu�l es el per�odo de la se�al?
% 
% En la gr�fica se puede observar f�cilmente como el periodo es de 1 ms.
% 
% �Con qu� par�metro de entrada de my_coseno est� relacionado?
% 
% el periodo del coseno est� relacionado con el par�metro f, ya que 1ms=1/f.


%% Ejercicio 2
%
% t debe ir de 0 a 3 ms
%
% La frecuencia de muestreo es 1 MHz. �Cu�l es la relaci�n de este par�metro
% con los par�metros de entrada de la funci�n my_coseno?
% 
% Fs est� relacoionado con el par�metro de entrada f, ya que Fs >> f, por lo que se cumple que
% Fs>2f (Teorema de Nyquist-Shannon) y por lo cual no se produce solapamiento.
%
% x1: coseno con amplitud 1 V, frecuencia 10 KHz y ning�n desfase
%
% x2: coseno con amplitud 2 V, frecuencia 23 KHz y un desfase positivo de 2 rad;
%
% x3: coseno con amplitud 2 V, frecuencia 7KHz y un desfase negativo de 1 rad. 
%
% x = x1 + x2 + x3;
% 

    fs=10^6;

% Genere x1 a continuaci�n
    [cos,temp]=my_coseno(3001,1/(10^6),10*10^3,0,1);

% Genere x2 a continuaci�n
    [cos1,temp1]=my_coseno(3001,1/(10^6),23*10^3,2,2);

% Genere x3 a continuaci�n
    [cos2,temp2]=my_coseno(3001,1/(10^6),7*10^3,1,2);
% Calcule la se�al compuesta como la suma de esos 3 cosenos

    coseno=cos+cos1+cos2;
% Represente la se�al obtenida en el dominio del tiempo entre 0 y 3 ms
% Etiquete el eje de abscisas y el de ordenadas y muestre rejilla 
figure
plot(temp*1000,coseno) % El tiempo lo multiplicamos por 1k para que se vea en ms
hold on
title('Suma de tres cosenos')
xlabel('Tiempo en ms')
ylabel('Coseno')
grid on

%% 
% Incluya aqu� su an�lisis 
% �Cu�l es el per�odo de x?
% 
% A trav�s de la gr�fica se puede observar que el periodo de x es de 1 ms;
%
% �Corresponde con la frecuencia fundamental esperada?
% 
% Si corresponde con lo esperado, ya que la frecuencia fundamental de la suma de los tres cosenos,
% es el m�nimo com�n multiplo entre las tres frecuencias fundamentales de cada coseno.
% 
% Debido a esto -> mcm(7,10,23)Khz = 1KHz <> 1ms.
%%
% A continuaci�n se proporciona el c�digo para calcular la FFT de x

NFFT = length(coseno);         % Longitud de la FFT 
X    = fft(coseno,NFFT)/NFFT;  % X como transformada de Fourier de x
df   = fs/NFFT;           % Resoluci�n en frecuencia
lg   = floor(NFFT/2);     % Se redondea NFFT/2 hacia abajo, por si NFFT es impar
f    = 0:df:(lg-1)*df;    % Vector de frecuencias

%
figure
stem(f/1000,abs(X(1:lg))); %dividimos la frecuencia entre 1k para pasa de Hz a kHz
hold on                   % Configure la llamada a stem para representar en el eje X la frecuencia en KHz                    % Ajuste el eje de frecuencias para mostrar con claridad las l�neas espectrales de la se�al 
xlabel('f(KHz)');         % Unidades del eje de abscisas
ylabel('V(V)');           % Unidades del eje de ordenadas
title('Representaci�n frecuencial');
axis([0 35 0 1.2])		%Ajusto los ejes para que se vean mejor
grid on;

%%
% An�lisis
%
% Incluya aqu� su an�lisis del m�dulo del espectro de x.
% Analice y justifique si los valores son los esperados tanto en el eje de
% abscisas como en el de ordenadas
% Mencionar amplitudes y frecuencias
%
% El resultado de la gr�fica de la representaci�n en frecuencia concuerda con lo esperados
%
% Primero: tenemos una delta a 7 KHz y con una amplitud de 1V. Concuerda ya que la f del cos = 7KHz y su amplitud es 2V (en frecuencia 2/2 = 1).
%
% Segundo: tenemos una delta a 10 KHz y con una amplitud de 05V. Concuerda ya que la f del cos = 10 KHz y su amplitud es 1V (en frecuencia 1/2=0.5).
%
% Tercero: tenemos una delta a 23 Khz y con una ampitud de 1V. Concuerda ya que la f del cos = 23KHz y su aplitud es 2V (en frecuencia 2/2 = 1).
%% Ejercicio 3
% Programe la funci�n modulaAM que toma los siguientes par�metros de
% entrada:
% fm: frecuencia de la se�al moduladora (Hz);
% mu: �ndice de modulaci�n (en porcentaje);
% fs: frecuencia de muestreo (Hz); 
% fc: frecuencia de la se�al portadora (en Hz); 
% Ac: amplitud de la se�al portadora (en V).

% Los par�metros de salida son:
% t: la referencia temporal (debe cubrir varios periodos de la moduladora);
% x_info_n: la se�al moduladora;
% y_AM: la se�al modulada en AM en el dominio del tiempo

% Configure los par�metros de entrada seg�n se indican en el enunciado
fm = 1300;      % Frecuencia de la se�al moduladora (Hz)
mu = 80;      % Indice de mdulaci�n (%)
fs = 200000;      % Frecuencia de muestreo (Hz)
fc = 15000;      % Frecuencia de la se�al portadora (Hz)
Ac = 2;      % Amplitud de la se�al portadora (V)

% Llame a la funci�n modulaAM
[t,x_info_n, y_AM] = modulaAM(fm, mu, fs, fc, Ac);

% Represente en la misma figura la se�al modulada en AM (en azul) y la se�al
% moduladora (en rojo). Las unidades del eje temporal deben ser ms.
% Etiquete los ejes adecuadamente, aj�stelos si lo considera necesario e incluya una leyenda que permita identificar cu�l es cada se�al. 
figure
title ('Se�al modulada y se�al moduladora');
plot(t*1000,y_AM,'b')
hold on
axis([0 3000/fm -4 4]);
plot(t*1000,x_info_n,'r');
xlabel('Tiempo en ms');
ylabel('Voltios');
legend ('modulada','moduladora');
grid on

%%
% AN�LISIS
%
% Como se puede observar, la se�al resultante no sufre sobremodulaci�n, y
% era lo que esper�bamos puesto que el �ndice de modulaci�n es 0.8.
%
% Hemos ajustado los ejes para que se puedan ver 3 periodos de muestreo.
% Adem�s, hemos tenido en cuenta el valor m�ximo de la envolvente (3.6) y
% m�nimo (0.4) al ajustar el eje y.

% Compare el periodo de la envolvente de la se�al modulada con el periodo
% de la moduladora.
% Como se puede ver, el periodo de la modulada es menor porque se encuentra
% a mayor frecuencia.
%
% Compruebe si el �ndice de modulaci�n es el esperado.
%
% m=Amax-Amin/2*Vmedio= (3.6-0.4)/2*2)=0.8 CORRECTO
%%
% Calcule la TF de la se�al info
    
    NFFT = length(x_info_n);         % Longitud de la FFT 
    X    = fft(x_info_n,NFFT)/NFFT;  % X como transformada de Fourier de x
    df   = fs/NFFT;           % Resoluci�n en frecuencia
    lg   = floor(NFFT/2);     % Se redondea NFFT/2 hacia abajo, por si NFFT es impar
    f    = 0:df:(lg-1)*df;  

% Calcule la TF de la se�al modulada  

     NFFT = length(y_AM);         % Longitud de la FFT 
    X2    = fft(y_AM,NFFT)/NFFT;  % X como transformada de Fourier de x
    df2   = fs/NFFT;           % Resoluci�n en frecuencia
    lg2   = floor(NFFT/2);     % Se redondea NFFT/2 hacia abajo, por si NFFT es impar
    f2    = 0:df2:(lg2-1)*df2;
% Utilizamos la funcion FFT proporcionada por Matlab

% Represente en la misma figura el espectro del m�dulo de la se�al modulada en AM (en azul) y de la se�al
figure
plot(f/1000,abs(X(1:lg)),'r');     
axis([0 18 0 3]);

hold on
plot(f/1000,abs(X2(1:lg2)),'b');
title ('Se�al moduladora y se�al modulada');
xlabel('f(KHz)');         
ylabel('V(V)');          
grid on 
legend ('moduladora', 'modulada');
%%
% AN�LISIS
%
% Para ajustar los ejes hemos tenido en cuenta las frecuencias esperadas de la se�al modulada al
% ser desplazadas debido a la frecuencia de la portadora (entre 14 y 18
% KHz). Tambi�n se muestra el espectro de la se�al de informaci�n. Su
% amplitud esperada es 0.5, por lo que nos coincide.
% Sin embargo, no sabemos por qu� la amplitud de la moduladora nos sale
% ligeramente atenuada y en vez de salirnos 1 en el piloto y 0.8 en las
% bandas laterales nos sale unos valores un poco m�s peque�os.

%% Ejercicio 4
% Programe la funci�n demodulaAM que toma los siguientes par�metros de
% entrada:
% y_mod: Se�al modulada (en el tiempo);
% fs: Frecuencia de muestreo (Hz); 
% fc: Frecuencia de la se�al portadora (en Hz); 
% filtro: Filtro paso bajo ajustado a la frecuencia de la se�al moduladora.
%
% Los par�metros de salida son:
%
% t: la referencia temporal;
% x_demod_before_filt: la se�al demodulada, en el dominio del tiempo, antes del filtrado
% x_demod_after_filt: la se�al demodulada, en el dominio del tiempo, despu�s del filtrado

ts=1/fs;
t = 0:ts:N;
% Cargue el filtro

load LowPassFilter
% Demodule la se�al modulada en el Ejercicio 3 llamando a demodulaAM
[t,demod_final,demod]=demodulaAm(y_AM,fs,fc,LowPassFilter);
% Represente en el dominio del tiempo la se�al demodulada (antes y despu�s de aplicar el filtrado) y la se�al moduladora. 
% El eje de tiempos debe estar en milisegundos.
% Las tres se�ales se representar�n en 3 plots independientes de la misma imagen (subplot).
% La primera en verde, la segunda en rojo, con trazo discontinuo, y la tercera en rojo, con trazo continuo
% Etiquete los ejes adecuadamente, aj�stelos si lo considera necesario e incluya una leyenda que permita identificar cu�l es cada se�al. 

figure
t=t*1000; %milisegundos

subplot(3,1,1)
plot(t,demod,'g');
hold on
title('demodulada antes del filtro');
xlabel('t(ms)');
ylabel('V(V)');
grid on;
axis([0 5 0 4]);

subplot(3,1,2)
hold on
plot(t,demod_final,'r-');
title('demodulada despu�s del filtro');
xlabel('t(ms)');
ylabel('V(V)');
grid on;
axis([0 5  -4 4])


subplot(3,1,3)
hold on
plot(t,x_info_n,'r')
title('Moduladora');
xlabel('t(ms)');
ylabel('V(V)');
grid on;
axis([0 5 -1 1]);
%%
% AN�LISIS
%
% La demodulaci�n que hemos utilizado es una demodulaci�n coherente (aunque
% podr�a servir el detector de envolvente ya que no hay sobremodulaci�n).
% En la misma hemos multiplicado la se�al modulada por un coseno con la
% misma frecuencia que la portadora, por lo que dicha se�al llamada
% "demodulada" se encuentra en una frecuencia el doble de mayor y por ello
% en la primera gr�fica se ve la parte oscura ya que altas frecuencias son
% variaciones r�pidas en el tiempo. Por otro lado, cargamos un filtro paso
% bajo con frecuencia de corte la frecuencia de lase�al de informaci�n, por loque filtra la
% se�al "demodulada" limit�ndola en banda por lo que "demod_final" se queda con frecuecia
% muy baja (1300 Hz) y en el tiempo desaparece la zona oscura. 
% La se�al moduladora o de informaci�n se representa sin la continua.
% Hemos ajustado los ejes para que se vean varios periodos de muestreo y
% teniendo en cuenta los valores m�ximos y m�nimos de la envolvente.
%%
% Represente en el dominio de la frecuencia la se�al demodulada antes y despu�s de aplicar el filtrado. 
% El eje de frecuencias estar� en KHz. 
% Las dos se�ales se representar�n en el mismo plot. La primera en verde y la segunda en rojo, con trazo discontinuo.
% Etiquete los ejes adecuadamente, aj�stelos si lo considera necesario e incluya una leyenda que permita identificar cu�l es cada se�al.
    NFFT = length(demod);         % Longitud de la FFT 
    X    = fft(demod,NFFT)/NFFT;  % X como transformada de Fourier de x
    df   = fs/NFFT;           % Resoluci�n en frecuencia
    lg   = floor(NFFT/2);     % Se redondea NFFT/2 hacia abajo, por si NFFT es impar
    f    = 0:df:(lg-1)*df;  
    
     
    NFFT = length(demod_final);         % Longitud de la FFT 
    X2   = fft(demod_final,NFFT)/NFFT;  % X como transformada de Fourier de x
    df2   = fs/NFFT;           % Resoluci�n en frecuencia
    lg2   = floor(NFFT/2);     % Se redondea NFFT/2 hacia abajo, por si NFFT es impar
    f2    = 0:df:(lg2-1)*df;  
    
% de nuevo hemos calculado la TDF de las dos se�ales mediante el comando
% FFT teniendo en cuenta que Matlab no divide la se�al entre el numero
% de puntos (NFFT). Cabe destacar que la longitud de ambas se�ales es la
% misma.
    figure
    subplot(1,2,1);
    plot(f/1000,abs(X(1:lg)),'r');      
    axis([0 40 0 2]);
    grid on
    title ('Se�al demodulada antes del filtro');
    xlabel('f(KHz)');         
    ylabel('V(V)'); 

    subplot(1,2,2)
    plot(f2/1000,abs(X2(1:lg2)),'b');
    axis([ 0 40 0 2]);
    title ('Se�al demodulada despu�s del filtro');
    xlabel('f(KHz)');         
    ylabel('V(V)');           
    grid on 
%%   
% AN�LISIS
%
% Como se esperaba en el espectro de frecuencias de la "demodulada" nos
% encontramos con que las deltas se desplazan al doble de la frecuencia de
% la portadora; sin embargo despu�s del filtro en la "demod_final" nos
% quedamos solo con el espectro de frecuencias menor que la frecuencia de la
% se�al de informaci�n.