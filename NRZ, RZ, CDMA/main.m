%% Práctica 5
% 
% Grupo 11
%
% Nombre1 Teresa González García
%
% Nombre2 Miguel Oleo Blanco

close all; clear all;


%% Ejercicio 1

M= 10;
Tb=1;
Ts=1/10000;
[secuencia_dig,x_NRZ_uni,x_NRZ_bi,x_RZ_uni,x_RZ_bi]=cod_pulsos_BB(M,Tb,Ts);

t=(0:Ts:M*Tb-Ts);
figure
subplot(2,2,1)
plot(t,x_NRZ_bi,'r');
grid on
title('xNRZbi')


subplot(2,2,2)
plot(t,x_NRZ_uni,'r');
grid on
title('xNRZuni')

subplot(2,2,3)
t=(0:Ts:M*Tb-Ts);
plot(t,x_RZ_bi,'r');
grid on
title('xRZbi')

subplot(2,2,4)
t=(0:Ts:M*Tb-Ts);
plot(t,x_RZ_uni,'r');
grid on
title('xRZuni')


M=40;
[secuencia_dig,x_NRZ_uni,x_NRZ_bi,x_RZ_uni,x_RZ_bi]=cod_pulsos_BB(M,Tb,Ts);

N= length(x_NRZ_bi);
figure
subplot(1,2,1)
x_NRZ_biF=20*log10(abs(fft(x_NRZ_bi)/N));
df=(1/Ts)/N;
f=(0:df:(N-1)*df);
plot(f,x_NRZ_biF);
hold on
axis([0 6 -60 0])
grid on
title('NRZ bi en frecuencia');

subplot(1,2,2)
x_NRZ_uniF=20*log10(abs(fft(x_NRZ_uni)/N));
df=(1/Ts)/N;
f=(0:df:(N-1)*df);
plot(f,x_NRZ_uniF);
hold on
axis([0 6 -60 0])
grid on
title('NRZ uni en frecuencia');

figure
subplot(1,2,1)
x_RZ_biF=20*log10(abs(fft(x_RZ_bi)/N));
df=(1/Ts)/N;
f=(0:df:(N-1)*df);
plot(f,x_RZ_biF);
hold on
axis([0 6 -60 0])
grid on
title('RZ bi en frecuencia');

subplot(1,2,2)
x_RZ_uniF=20*log10(abs(fft(x_RZ_uni)/N));
df=(1/Ts)/N;
f=(0:df:(N-1)*df);
plot(f,x_RZ_uniF);
hold on
axis([0 6 -60 0])
grid on
title('RZ uni en frecuencia');

figure
subplot(2,2,1)
x_NRZ_biF=20*log10(abs(fft(x_NRZ_bi)/N));
df=(1/Ts)/N;
f=(0:df:(N-1)*df);
plot(f,x_NRZ_biF);
hold on
axis([0 6 -60 0])
grid on
title('NRZ bi en frecuencia');

subplot(2,2,2)
x_NRZ_uniF=20*log10(abs(fft(x_NRZ_uni)/N));
df=(1/Ts)/N;
f=(0:df:(N-1)*df);
plot(f,x_NRZ_uniF);
hold on
axis([0 6 -60 0])
grid on
title('NRZ uni en frecuencia');

subplot(2,2,3)
x_RZ_biF=20*log10(abs(fft(x_RZ_bi)/N));
df=(1/Ts)/N;
f=(0:df:(N-1)*df);
plot(f,x_RZ_biF);
hold on
axis([0 6 -60 0])
grid on
title('RZ bi en frecuencia');

subplot(2,2,4)
x_RZ_uniF=20*log10(abs(fft(x_RZ_uni)/N));
df=(1/Ts)/N;
f=(0:df:(N-1)*df);
plot(f,x_RZ_uniF);
hold on
axis([0 6 -60 0])
grid on
title('RZ uni en frecuencia');
%%
% COMENTARIO:
% 
% En no retorno a cero se puede observar que en frecuencia, la señal se anula en multiplos de
% 1/Ts, ya que tiene forma de sinc. 
% 
% En retorno a cero, sucede igual, pero se hace cero en multiplos de 2/Ts,
% por lo que ocupa el doble de ancho de banda, lo cual concuerda con lo visto en clase.
%
% También es importante observar las graficas de unipolar y bipolar en
% frecuencia son ligeramente distintas, ya que se puede observar que en unipolar hay una componente
% en contínua (frec = 0 Hz), lo cual concuerda también con lo visto en
% clase.

figure
img = imread('foto.JPG');
imshow(img);
title('Secuencia 1011011011 representada en distintos alfabetos');
%% Ejercicio 2

CDMA_2_chips;
%%
% COMENTARIO:
%
% Se puede ver por el resultado en la consola que los códigos recibidos son idénticos a los enviados.
%
% En las gráficas se puede ver fácilmente el proceso de multiplexación por código.
%
% También cabe destacar, que las gráficas de frecuencia concuerdan, ya que
% la señal enviada (suma de cada una codificada), es la suma de cada señal
% codificada por separado.
%% Ejercicio 3
CDMA_4_chips;
%%
% COMENTARIO:
% 
% Se comprueba que la secuencia generada y enviada es la misma que la
% recibida ya que hemos utilizado unos códigos de profundidad 4 ortogonales
% entre si. Gracias a esto se puede realizar el proceso satisfactoriamente
% (ya que podemos recuperarlas).
%
% DATO CURIOSO. En la grafica en la que se muestra en frecuencia la señal 1 antes de multiplexar y después,
% se puede observar que no cambia. Esto se debe a que el código que
% multiplica a la señal 1 es (1,1,1,1), por lo que antes y despues de
% multiplexar, la señal se queda esactamente igual. Para contrasta esto,
% repetimos esto mismo con la señal dos, y deberiamos notar el
% esanchamiento.


%% Opcional Ejercicio 3
CDMA_4_chips_Opcional;
%%
% Se puede ver que la secuencia recibida no es idéntica a la primera si
% cambiamos los códigos y dejan de ser ortogonal. Además, los valores
% recibidos, son diferentes unos entre otros y debido a esto, no lo podemos
% arreglar con un aplificador para dejarlo todos a 1.

