function [x] = muestreo(secuencia, NTs)
%
% Esta funci�n entrega el resultado de muestrear el vector secuencia con NTs muestras.
% NTs es por tanto la duraci�n de secuencia en m�ltiplos del periodo de muestreo
%
% N�mero de bits, M
  M = length(secuencia);  
% N�mero de chips por bit
  Nc = round(NTs/M);
% Se�al muestreadora
  x = ones(1, M*Nc);
% Muestreo
  x = repmat(secuencia', 1, Nc);
  x = reshape(x',1, M*Nc);
%
end 
