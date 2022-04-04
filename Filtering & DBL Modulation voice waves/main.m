%% Práctica 3
% 
% Grupo 11
%
% Nombre1 Miguel Oleo Blanco
%
% Nombre2 Teresa González García

close all; clear all; format compact;


%% Ejercicio 1

% Importar señales
senyal=importdata('x1.wav');
x1=senyal.data(:,1)'; %Señal de información (voz) 1
FsBB=senyal.fs; %Frecuencia de muestreo de las señales de información (voz)
N = length(x1); %Longitud de las señales de información (voz)
sound(x1, FsBB); %Para reproducir la señal de voz 1

% Importar y reproducir señales 2 y 3
senyal2=importdata('x2.wav');
x2=senyal2.data(:,1)'; %Señal de información (voz) 2
FsBB2=senyal2.fs; %Frecuencia de muestreo de las señales de información (voz)
N2 = length(x2); %Longitud de las señales de información (voz)
sound(x2, FsBB2); %Para reproducir la señal de voz 2

senyal3=importdata('x3.wav');
x3=senyal3.data(:,1)'; %Señal de información (voz) 3
FsBB3=senyal2.fs; %Frecuencia de muestreo de las señales de información (voz)
N3 = length(x3); %Longitud de las señales de información (voz)
sound(x3, FsBB3); %Para reproducir la señal de voz 3

% Aplicar el filtro a cada señal
Hd=filtro();
a=1;
b=Hd.Numerator;
x1_f=filter(b,a,x1);
x2_f=filter(b,a,x2);
x3_f=filter(b,a,x3);

% Generar las frecuencias de las portadoras para la modulación DBL
fc1 = 5000;
fc2 = 15000;
fc3 = 25000;
 
% Crear el vector de tiempos para las portadoras, con la misma longitud que
% las señales y su frecuencia de muestreo
t=0:1/FsBB:(N-1)/FsBB;

% Modular en DBL cada señal BB con la portadoras correspondiente para crear el espectro FDM
x1_Tx = x1_f.* cos(2*pi*fc1*t);
x2_Tx = x2_f.* cos(2*pi*fc2*t);
x3_Tx = x3_f.* cos(2*pi*fc3*t);
 
% Generar la señal compuesta
x_Tx = x1_Tx + x2_Tx + x3_Tx;
 
% Generar el espectro de cada una de las señales originales por separado
X1=fft(x1)/(length(x1));
X2=fft(x2)/(length(x2));
X3=fft(x3)/(length(x3));
 
% Generar el espectro de cada una de las señales moduladas por separado
X1_Tx=fft(x1_Tx)/(length(x1_Tx));
X2_Tx=fft(x2_Tx)/(length(x2_Tx));
X3_Tx=fft(x3_Tx)/(length(x3_Tx));
 
% Crear la señal recibida como si el canal fuera ideal
y_Rx=x_Tx;
 
% Generar las señales demoduladas multiplicando por el tono correspondiente
y1 = x1_Tx.* cos(2*pi*fc1*t);
y2 = x2_Tx.* cos(2*pi*fc2*t);
y3 = x3_Tx.* cos(2*pi*fc3*t);
 
% Generar los espectros para la representación en frecuencia
Y1 = fft(y1)/(length(y1));
Y2 = fft(y2)/(length(y2));
Y3 = fft(y3)/(length(y3));
 
% Filtrar paso bajo todas las señales 
% ¿Qué filtro puede utilizar para realizar esta operación?
y1_f = filter(b,a,y1);
y2_f = filter(b,a,y2);
y3_f = filter(b,a,y3);
 
% Generar los espectros para la representacion en frecuencia
Y1_f = fft(y1_f)/(length(y1_f));
Y2_f = fft(y2_f)/(length(y2_f));
Y3_f = fft(y3_f)/(length(y3_f));
 
% Representar las señales en el tiempo y en la frecuencia en los diferentes
% puntos que se especifican en el enunciado
% SEÑALES ORIGINALES
f=linspace(-.5,.5,N)*FsBB; %Referencia FRECUENCIAL

figure
subplot(3, 1, 1)
plot(f*1e-3,1000*fftshift(abs(X1)), 'b')
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
title('Señales originales X1')
axis([-30 30 0 1000*max(abs(X1))]); 
grid on 

subplot(3, 1, 2)
plot(f*1e-3,1000*fftshift(abs(X2)), 'r')
title('Señales originales X2')
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
axis([-30 30 0 1000*max(abs(X2))]); 
grid on 

subplot(3, 1, 3)
plot(f*1e-3,1000*fftshift(abs(X3)), 'g')
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
title('Señales originales X3')
axis([-30 30 0 1000*max(abs(X3))]); 
grid on 

% SEÑALES MODULADAS
figure
subplot(4,1,1)
plot(f*1e-3,1000*fftshift(abs(X1_Tx)), 'b')
hold on
grid on
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
title('Multiplex modulado X1')

subplot(4,1,2)
plot(f*1e-3,1000*fftshift(abs(X2_Tx)), 'r')
hold on
grid on
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
title('Multiplex modulado X2')

subplot(4,1,3)
plot(f*1e-3,1000*fftshift(abs(X3_Tx)), 'g')
hold on
grid on
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
title('Multiplex modulado X3')
%MULTIPLEXACIÓN CONJUNTA
subplot(4,1,4)
plot(f*1e-3,1000*fftshift(abs(X1_Tx)), 'b')
hold on
plot(f*1e-3,1000*fftshift(abs(X2_Tx)), 'r')
hold on
plot(f*1e-3,1000*fftshift(abs(X3_Tx)), 'g')
hold on
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
grid on
legend('X1 multiplexado','X2 multiplexado','X3 multiplexado')
title('Multiplex modulado')

% SEÑALES DEMODULADAS Y FILTRADAS
figure
subplot(3, 1, 1)
plot(f*1e-3,1000*fftshift(abs(Y1_f)), 'b')
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
title('Multiplex demodulado y filtrado Y1_f')
axis([-30 30 0 1000*max(abs(Y1_f))]);
grid on  

subplot(3, 1, 2)
plot(f*1e-3,1000*fftshift(abs(Y2_f)), 'r')
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
title('Multiplex demodulado y filtrado Y2_f')
axis([-30 30 0 1000*max(abs(Y2_f))]);
grid on

subplot(3, 1, 3)
plot(f*1e-3,1000*fftshift(abs(Y3_f)), 'g')
title('Multiplex demodulado y filtrado Y3_f')
xlabel('Frecuencia (KHz)')
ylabel('Voltaje (mV)')
axis([-30 30 0 1000*max(abs(Y3_f))]);
grid on



%% Ejercicio 2

Fs=15000;    %Frecuencia de muestreo
N=300;      %Número de puntos
fc = 500;
%Generar la señal moduladora (una rampa)
m=[(-N/2:(N/2)-1)]/N*2;

%Generar la referencia temporal
t=0:1/Fs:(N-1)/Fs;  

%Calcular la frecuencia instantanea (en base a la señal moduladora)
finst = fc + fc*m;  

%Generar la señal modulada usando la frecuencia instantanea
x = cos(2*pi*finst.*t);   

%Representar la señal moduladora (rampa) y la modulada 
figure
plot(1000*t,m,'r');
hold on
grid on
xlabel('Tiempo (ms)')
ylabel('Voltaje (V)')
plot(1000*t,x,'g');

%% 
% Explique la forma obtenida en la señal modulada, relacionándola con lo aprendido sobre modulación FM en el Tema 3
%
% En la gráfica obtenida se muestra en rojo la señal de información en
% forma de rampa en el intervalo [-1,1] y la modulada en verde, con el eje de tiempos ajustado en ms. Como se
% puede ver, la señal modulada presenta una clara forma de "acordeón",
% fenómeno propio de las señales moduladas en frecuencia. Al representarlas
% juntas, se puede identificar fácilmente las zonas en las que la señal de
% información (rampa) es negativa y positiva. El efecto producido en la
% señal resultante se debe a que en las zonas negativas la señal modulada
% se retrasa (menor frecuencia, vibraciones más lentas, se ensancha el espectro) con respecto a la moduladora y en las zonas positivas se
% adelanta (mayor frecuencia, vibraciones más rápidas, se estrecha el espectro).
% 
