function [yx, rx] = CDMA_rx(y_CDMA, codigo, M, Tb, Ts)
%
% Esta funci�n entrega el resultado de correlar una se�al con un c�digo. 
%
% M         n�mero de bits
% Tb        periodo de bit
% Ts        periodo de muestreo
% y_CDMA    se�al que se va a correlar con el c�digo. Su longitud es M*Tb/Ts
% codigo    C�digo. Su longitud es la profundidad del c�digo.
%
% yx        producto de se�al por el c�digo muestreado con periodo Ts
% rx        se�al resultante de integrar yx durante el periodo de bit
%
% Producto de la se�al por el c�digo
  N_bit = round(Tb/Ts);
  codigo_rep   = repmat(codigo, 1, M);
  y_codigo = muestreo(codigo_rep, M*Tb/Ts);
  yx    = y_CDMA.*y_codigo;    
% Integraci�n sobre el periodo de bit
  y_aux = reshape(yx, N_bit, M);
  rx    = sum(y_aux)/N_bit;       % sumo la variable por filas
%
end 
 


