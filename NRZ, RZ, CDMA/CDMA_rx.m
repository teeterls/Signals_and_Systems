function [yx, rx] = CDMA_rx(y_CDMA, codigo, M, Tb, Ts)
%
% Esta función entrega el resultado de correlar una señal con un código. 
%
% M         número de bits
% Tb        periodo de bit
% Ts        periodo de muestreo
% y_CDMA    señal que se va a correlar con el código. Su longitud es M*Tb/Ts
% codigo    Código. Su longitud es la profundidad del código.
%
% yx        producto de señal por el código muestreado con periodo Ts
% rx        señal resultante de integrar yx durante el periodo de bit
%
% Producto de la señal por el código
  N_bit = round(Tb/Ts);
  codigo_rep   = repmat(codigo, 1, M);
  y_codigo = muestreo(codigo_rep, M*Tb/Ts);
  yx    = y_CDMA.*y_codigo;    
% Integración sobre el periodo de bit
  y_aux = reshape(yx, N_bit, M);
  rx    = sum(y_aux)/N_bit;       % sumo la variable por filas
%
end 
 


