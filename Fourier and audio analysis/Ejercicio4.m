function Ejercicio4
%01454

fs=44100;
dt=1/fs;
t=0:dt:50*10^-3;
nulos(1:length(t))=0;
x1(1:length(t))=cos(2*pi*1981.*t);
x2(1:length(t))=cos(2*pi*1124.*t);
x3(1:length(t))=cos(2*pi*1358.*t);
x4(1:length(t))=cos(2*pi*1446.*t);
x5(1:length(t))=cos(2*pi*1358.*t);
x=[nulos,x1,nulos,x2,nulos,x3,nulos,x4,nulos,x5,nulos];
dibujaTdF(x,dt);
sound(x,1/dt);
tiempo=linspace(0,10*50*10^-3,length(x));
figure;
plot(tiempo,x);
title('Representacion temporal');
xlabel('Segundos');
ylabel('Valores');
grid on;
end

