function Ejercicio3()
T = 5e-3; % Periodo fundamental
w0 = 2*pi/T;
N = 7; % Número de coeficientes por cada lado
k = -N:N;
t = -3*T:1/15e3:3*T; % Eje de tiempos
w = w0*k;
%----------------
pos=1;
% Diseño del filtro con la frecuencia de corte apropiada, filtrado de los coeficientes (ck_out), y síntesis de la señal (x_out) a partir de los coeficientes filtrados ? A RELLENAR
ck=[0,1,0,0,0,0,1,0,1,0,0,0,0,1,0];
w_corte = 2*w0; % A elegir por el alumno

s = 1i*w/w_corte;
H2 =1./(s.^3 +2*(s.^2)+2*s+1);
ck_out = ck.*H2;
acumulador =0;
for iter=-N:N
    exponencial = exp((j*2*pi*t*iter)/T);
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

