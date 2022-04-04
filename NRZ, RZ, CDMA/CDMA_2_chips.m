close all; clear; format compact;
M     = 20;                 % Numero de bits de la secuencia
Tb    = 1;                  % Periodo de bit en segundos
Ts    = Tb/10000;            % Periodo de muestreo
fs    = 1/Ts;
N_bit = round(Tb/Ts);              % Numero de muestras por bit

%% C�digos ortogonales de potencia constante en el tiempo
   codigo_1 = [-1 1];
   codigo_2 = [1 1];

%  Secuencias binarias aleatorias e inicializaci�n de las secuencias recibidas
   secuencia_dig_1    = randi([0,1],1, M)
   secuencia_dig_1_rx = zeros (1, M);
   secuencia_dig_2    = randi([0,1],1, M)
   secuencia_dig_2_rx = zeros (1, M);

%% Creo la se�al de pulsos de la secuencia 1 con c�digo NRZ unipolar
   x_1 = muestreo(secuencia_dig_1, M*Tb/Ts);

%% Genero la se�al CDMA con el c�digo 1 
   codigo_1_rep   = repmat(codigo_1, 1, M);
   senal_codigo_1 = muestreo(codigo_1_rep, M*Tb/Ts);
   x_CDM_1 = x_1.*senal_codigo_1;

%% Represento las se�ales
   t_plot = 0:(1/fs):(M*Tb)-(1/fs);   % Construyo el eje de tiempos para los plots

   figure
   subplot(3,1,1)
   plot(t_plot, x_1, 'b');
   title('Usuario 1')
   hold on
   plot(t_plot, x_CDM_1, '--b');
   axis ([0 (M*Tb) -1.5 1.5]);
   grid on

%% Creo la se�al de pulsos de la secuencia 2 con c�digo NRZ unipolar
   x_2 = muestreo(secuencia_dig_2, M*Tb/Ts);

%% Genero la se�al CDMA con el c�digo 2  
   codigo_2_rep   = repmat(codigo_2, 1, M);
   senal_codigo_2 = muestreo(codigo_2_rep, M*Tb/Ts);
   x_CDM_2 = x_2.*senal_codigo_2;

%% Represento las se�ales
   subplot(3,1,2)
   plot(t_plot, x_2, 'r');
   hold on
   plot(t_plot, x_CDM_2, '--r');
   title('usuario 2')
   axis ([0 (M*Tb) -1.5 1.5]);
   grid on

%% Genero la suma de las dos se�ales en el canal y la represento
   y_CDM = x_CDM_1 + x_CDM_2;
   subplot(3,1,3)
   plot(t_plot, y_CDM, 'g');
   xlabel('t(s)')
   title('se�al suma de los dos usuarios en el canal')
   axis ([0 (M*Tb) -2.5 2.5]);
   grid on
%
% Representaci�n gr�fica espectral
  NFFT = length(y_CDM);
  df   = fs/NFFT;
  lg   = floor(NFFT/2);
  frec = 0:df:(lg-1)*df;
  X_CDM_1 = fft(x_CDM_1, NFFT)/NFFT;
  X_CDM_2 = fft(x_CDM_2, NFFT)/NFFT; 
  Y_CDM   = fft(y_CDM, NFFT)/NFFT;
%
  figure
  subplot(3,1,1)
  plot(frec, 20*log10(abs(X_CDM_1(1:lg))));
  axis ([0 10 -60 10]);
  title('Usuario 1 multiplexado en c�digo')
  grid on
  
  subplot(3,1,2)
  plot(frec, 20*log10(abs(X_CDM_2(1:lg))));
  axis ([0 10 -60 10]);
  title('Usuario 2 multiplexado en c�digo')
  
  subplot(3,1,3)
  plot(frec, 20*log10(abs(Y_CDM(1:lg))));
  axis ([0 10 -60 10]);
  title('M�ltiplex en c�digo')
  xlabel('f(Hz)')
  grid on   
%
%% Recepci�n
%   
%% Deshago la CDM en el receptor del usuario 1
  [y_CDM_1, secuencia_dig_1_rx] = CDMA_rx(y_CDM, codigo_1, M, Tb, Ts);

%% Escribo la secuencia recibida por el usuario 1 en la ventana de comandos 
   secuencia_dig_1_rx

%% Deshago la CDM en el receptor del usuario 1
   [y_CDM_2, secuencia_dig_2_rx] = CDMA_rx(y_CDM, codigo_2, M, Tb, Ts);

%% Escribo la secuencia recibida por el usuario 1 en la ventana de comandos  
    secuencia_dig_2_rx

%% Represento las se�ales recibidas
  figure
  subplot(3,1,1)
  plot (t_plot, y_CDM, 'g');
  title('Se�al recibida por los dos usuarios')
  axis ([0 (M*Tb) -2.5 2.5]);
  grid on

  subplot(3,1,2)
  plot (t_plot, y_CDM_1, 'b');
  axis ([0 (M*Tb) -2.5 2.5]);
  title('Se�al extraida por el usuario 1 (antes de la integraci�n)')
  grid on

  subplot(3,1,3)
  plot (t_plot, y_CDM_2, 'r');
  axis ([0 (M*Tb) -2.5 2.5]);
  xlabel('t(s)')
  title('Se�al extraida por el usuario 2 (antes de la integraci�n')
  grid on
