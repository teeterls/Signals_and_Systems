function untitled7
T = 5e-3; % Periodo fundamental
w0 = 2*pi/T;
N = 7; % Número de coeficientes por cada lado
k = -N:N;
t = -3*T:1/15e3:3*T; % Eje de tiempos
w = w0*k;
%----------------
% Diseño del filtro con la frecuencia de corte apropiada, filtrado de los coeficientes (ck_out), y síntesis de la señal (x_out) a partir de los coeficientes filtrados ? A RELLENAR
w_c=2*w0; %frecuencia más alta de los dos tonos
[acum,c_n]=ejercicio2_2;
% w = linspace(-100*pi,100*pi,1e5);
s = 1i*w/w_c 
H2 = 1./(s.^2+1.4142*s+1);
ck_out=c_n.*H2;
acumulador = 0; %Utilizo esta variable para ir acumulando el resultado de la suma
for iter = -N:1:N
    exponencial = exp((j*2*pi*t*iter)/T); % Calculo la exponencial 
    acumulador = acumulador + ck_out(iter+N+1) * exponencial;
end

%----------------
figure
plot(t,real(acumulador))
title('Señal sintetizada a la salida del filtro')
ylabel('Amplitud')
xlabel('Tiempo [s]')

figure
stem(k,abs(ck_out))
title('DSF a la salida del filtro')
ylabel('Amplitud coeficientes')
xlabel('k')

end

