function [acumulador,c_k]=ejercicio2_2
T = 5e-3; % Periodo fundamental
w0 = 2*pi/T;
N = 7; % Número de coeficientes por cada lado
k = -N:N;
t = -3*T:1/15e3:3*T; % Eje de tiempos
%----------------
% Cálculo de los coeficientes y síntesis de la señal
for iter = 1:2*N+1
    if(iter==9 || iter==14)
        c_k(iter)=1;
        c_k(iter-2*(iter-8))=1;
    else
        c_k(iter)=0;
    end
end
%----------------Síntesis de la señal
acumulador = 0; %Utilizo esta variable para ir acumulando el resultado de la suma
for iter = -N:1:N
    exponencial = exp((j*2*pi*t*iter)/T); % Calculo la exponencial 
    acumulador = acumulador + c_k(iter+N+1) * exponencial;
end

figure
plot(t,real(acumulador))
title('Señal sintetizada')
ylabel('Amplitud')
xlabel('Tiempo [s]')

figure
stem(k,abs(c_k))
title('DSF')
ylabel('Amplitud coeficientes')
xlabel('k')

reproduce_senyal(real(acumulador))
end