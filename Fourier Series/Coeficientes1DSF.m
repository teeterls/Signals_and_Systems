function Coeficientes1DSF(T,V,N)
%T = 5; %periodo fundamental
t = linspace(-5*T,5*T,1e4); % Vector temporal en el que voy a representar la se?al peri?dica. Utilizo 10 periodos, desde -5T hasta 5T.

% Calculo el valor de los coeficientes. 
%N = ?? ; % N?mero de coeficientes (de ?ndice positivo) que voy a querer generar
n=-N:N; %genera los 2N+1 t?rminos

% C?lculo de los coeficientes. Deber? un vector de 2*N+1 componentes 
pos=1;
for i=-N:1:N
c_n(pos)= (V/2)*sinc(i/2)*exp(-j*pi*i/2);
pos=pos+1;
end
%Calculo de los coeficientes de la senoidal
pos=1;
for i=-N:1:N
   if(mod(N,2)==0)
       c_ns(pos)=(V/pi)*(1/1-N^2);
       pos=pos+1;
   end
   if(N==1 || N==-1)
       c_ns(pos)=(-V*j*N)/4;
       pos=pos+1;
   else
       c_ns(pos)=0;
       pos=pos+1;
   end
   
end

    

% S?ntesis de la se?al peri?dica bas?ndome en el DSF. 
% Tengo que construir la parte de la exponencial en base al ?ndice (n) y al
% vector temporal (t) que he construido anteriormente. Una vez tengo los
% vectores correspondientes a las exponenciales, multiplico cada una de
% ellas por el coeficeinte correspondiente del DSF. Una manera "sencilla"
% de hacerlo es con un bucle for: 

acumulador = 0;
acumulador2=0;      %Utilizo esta variable para ir acumulando el resultado de la suma
for iter = -N:1:N
    exponencial = exp(j*iter*2*pi.*t/T); % Calculo la exponencial 
    acumulador = acumulador + c_n(iter+N+1) .* exponencial;
    acumulador2= acumulador2 + c_ns(iter+N+1) .* exponencial;
end

% Ser?a un buen ejercicio intentar hacerlo con sin el bucler for

figure
plot(t,acumulador)
xlabel('Tiempo [s]')
ylabel('x(t)')
title('Senyal reconstruida')

figure
stem(n,abs(c_n))
xlabel('Numero de coeficiente [k]')
ylabel('|c_n|')
title('Coeficientes del DSF')

figure
plot(t,acumulador2)
xlabel('Tiempo [s]')
ylabel('x(t)')
title('Senyal reconstruida')

figure
stem(n,abs(c_ns))
xlabel('Numero de coeficiente [k]')
ylabel('|c_n|')
title('Coeficientes del DSF')
end