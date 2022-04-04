function [secuencia_dig, x_NRZ_uni, x_NRZ_bi, x_RZ_uni, x_RZ_bi] = cod_pulsos_BB (M, Tb,Ts)

% M:  Numero de bits de la secuencia
% Tb: Periodo de bit en segundos
% Ts: Periodo de muestreo
% 
  fs    = 1/Ts;                 % Frecuencia de muestreo
%
% Genero la secuencia aleatoria de bits
  secuencia_dig  = randi([0,1],1, M);
%
% NRZ unipolar
% La señal NRZ unipolar es la secuencia binaria muestreada con periodo de muestreo Ts
  x_NRZ_uni = muestreo(secuencia_dig, M*Tb/Ts);
%
% NRZ bipolar
% La señal NRZ bipolar se obtiene por ajuste de escala y desplazamiento de nivel de la unipolar
   x_NRZ_bi = 2*x_NRZ_uni - 1;
%
% RZ unipolar
% Localizo qué posiciones de la secuencia corresponden a 1s 
  f1 = find(secuencia_dig==1);
% Creo x_RZ_uni como una matriz de M filas y 2 columnas de 0s
  x_RZ_uni = zeros(M, 2);
% Reemplazo las filas correspondientes a 1s con la secuencia [1 0].
  x_RZ_uni(f1,:) = repmat([1 0], length(f1), 1); 
% Convierto la matriz en un vector y muestreo con periodo Ts
  x_RZ_uni = reshape(x_RZ_uni', 1, 2*M);
  x_RZ_uni = muestreo(x_RZ_uni, M*Tb/Ts);
%  
% RZ bipolar
% Localizo qué posiciones de la secuencia corresponden a 0s 
  f0 = find(secuencia_dig==0);
% Creo x_RZ_bi como una matriz de M filas y 2 columnas de 0s
  x_RZ_bi = zeros(M, 2);
% Reemplazo las filas correspondientes a 1s con la secuencia [1 0].
  x_RZ_bi(f1,:) = repmat([1 0], length(f1), 1); 
% Reemplazo las filas correspondientes a 0s con la secuencia [-1 0].
  x_RZ_bi(f0,:) = repmat([-1 0], length(f0), 1);  
% Convierto la matriz en un vector y muestreo con periodo Ts
  x_RZ_bi = reshape(x_RZ_bi', 1, 2*M);
  x_RZ_bi = muestreo(x_RZ_bi, M*Tb/Ts);
