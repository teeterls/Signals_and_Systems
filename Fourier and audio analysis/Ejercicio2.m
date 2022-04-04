function Ejercicio2
f0=10;
T=1;
f1=200;
k=(f1-f0)/2*T;
dt=1e-3;
t=0:dt:T;

x=cos(2*pi*(f0+k.*t).*t);
figure;
plot(t,x)
title('Representacion temporal')
xlabel('Segundos')
ylabel('x=cos(2*pi*(f0+k.*t).*t)')
grid on;

dibujaTdF(x,dt);

figure
[s,f,t] = spectrogram(x,64,63,f1,1/dt,'yaxis');
[F,T] = meshgrid(f,t);
mesh(T,F,10*log10(abs(s))')
title('Linear Chirp')
xlabel('Tiempo [s]')
ylabel('Frecuencia [Hz]')
zlabel('Espectro señal')

end

