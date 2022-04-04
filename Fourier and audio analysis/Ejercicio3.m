function Ejercicio3
[data,fs] = audioread('CCIR_04221.wav');
dt=1/fs;
t=linspace(0,5,143376);
figure;
plot(t,data)
title('Representacion temporal')
xlabel('Segundos')
ylabel('datos')
grid on;

dibujaTdF(data,dt);
plotSELCALLspectrogram(data)

t1=linspace(0,0.86,24600);
recor=data(1:24600);
figure;
plot(t1,recor);
title('Representacion temporal recortada');
xlabel('Segundos');
ylabel('Datos');
grid on;
dibujaTdF(recor,dt);
sound(recor,1/dt);
end

