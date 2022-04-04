function [coseno,temp] = my_coseno(N,Ts,f,Phi,A)

%Creo base de tiempos. Empieza en 0, y tiene N puntos, entonces como
%tenemos el periodo de muestreo, el max = Ts*(N-1)
temp=linspace(0,Ts*(N-1),N);
coseno=A*cos(2*pi*f*temp+Phi);
end

