function Ejercicio2()
T = 5e-3; % Periodo fundamental
w0 = 2*pi/T;
N = 7; % Número de coeficientes por cada lado
k = -N:N;
t = -3*T:1/15e3:3*T; % Eje de tiempos
%----------------
ck = [0,1,0,0,0,0,1,0,1,0,0,0,0,1,0];
x=0;
pos=1;
for i=-N:N
    x =x + ck(pos)*exp(j*w0.*t*i);
    pos=pos+1;
end
%----------------
reproduce_senyal(real(x));
figure
plot(t,real(x))
title('Señal sintetizada')
ylabel('Amplitud')
xlabel('Tiempo [s]')
figure
stem(k,abs(ck))
title('DSF')
ylabel('Amplitud coeficientes')
xlabel('k')

end

