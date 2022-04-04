function [secuencia_bits_rx] = demodQPSK(secuencia_simbolos_rx,nSym)
secuencia_bits_rx = zeros(1,length(secuencia_simbolos_rx)*2); %preallocation para los bits demodulados
 
% Para el caso de QPSK, recorro cada uno de los simbolos recibidos
for i = 1:nSym
    angulo = angle(secuencia_simbolos_rx(i));
    binaryWord=0;
    %Para cada uno de los simbolos, calculo su angulo y discrimino
    %en cual de los 4 sectores se encuentra. Cuando conozco el
    %sector ya puedo asociar la palabra binaria correpondiente
    if (angulo <= pi/4 && angulo > -pi/4)
        binaryWord = [ 0 0]; 
    elseif (angulo <= 3*pi/4 && angulo > pi/4)
         binaryWord = [0 1];
    elseif (angulo <= -3*pi/4 || angulo > 3*pi/4)
        binaryWord = [1 1];
    elseif (angulo <= -pi/4 && angulo > -3*pi/4)
        binaryWord = [1 0];
    end
   
    %Relleno el vector de salida (secuencia_bits_rx) con la palabra binaria adjudicada
    %anteriormente. He de colocar la palabra en la posicion correcta.
    secuencia_bits_rx((i-1)*2+1:i*2) = binaryWord;
end

end

