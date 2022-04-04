function [x] = muestreo(secuencia, NTs)
%
% Esta función entrega el resultado de muestrear el vector secuencia con NTs muestras.
% NTs es por tanto la duración de secuencia en múltiplos del periodo de muestreo
%
% Número de bits, M
  M = length(secuencia);  
% Número de chips por bit
  Nc = round(NTs/M);
% Señal muestreadora
  x = ones(1, M*Nc);
% Muestreo
  x = repmat(secuencia', 1, Nc);
  x = reshape(x',1, M*Nc);
%
end 
