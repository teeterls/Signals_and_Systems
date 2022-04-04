function Ejercicio1(f1)
f0=10;
T=1;
k=(f1-f0)/2*T;
dt=1e-4;
t=0:dt:T;

x=cos(2*pi*(f0+k.*t).*t);
figure;
plot(t,x)
title('Representacion temporal')
xlabel('Segundos')
ylabel('x=cos(2*pi*(f0+k.*t).*t)')
grid on;


dibujaTdF(x,dt);
end

