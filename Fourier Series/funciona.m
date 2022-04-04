T = 5; %periodo fundamental
t = linspace(-5*T,5*T,1e4); % Vector temporal en el que voy a representar la se?al peri?dica. Utilizo 10 periodos, desde -5T hasta 5T.

% Calculo el valor de los coeficientes. 
N = 50 ; % N?mero de coeficientes (de ?ndice positivo) que voy a querer generar
n=-N:N; %genera los 2N+1 t?rminos
c_n= -(exp(1i*pi*(1-n))-1)./((1-n).*4*pi)-(exp(-1i*pi*(1+n))-1)./((1+n).*4*pi);

% C?lculo de los coeficientes. Deber? un vector de 2*N+1 componentes 


% S?ntesis de la se?al peri?dica bas?ndome en el DSF. 
% Tengo que construir la parte de la exponencial en base al ?ndice (n) y al
% vector temporal (t) que he construido anteriormente. Una vez tengo los
% vectores correspondientes a las exponenciales, multiplico cada una de
% ellas por el coeficeinte correspondiente del DSF. Una manera "sencilla"
% de hacerlo es con un bucle for: 

acumulador = 0; %Utilizo esta variable para ir acumulando el resultado de la suma
for iter = -N:1:N
    exponencial = exp(2*pi*t*iter*1i/T); % Calculo la exponencial 
    if iter==1
        acumulador = acumulador +(1i*pi+(exp(-1i*pi*(1+iter))-1)./(1+iter))./(-4*pi) .* exponencial;
    elseif iter==-1
        acumulador = acumulador -(exp(1i*pi*(1-iter))-1)./((1-iter).*4*pi)+(1i*pi)./(4*pi) .* exponencial;
    else
    acumulador = acumulador + c_n(iter+N+1) .* exponencial;
    end
end

% Ser?a un buen ejercicio intentar hacerlo con sin el bucler for
x= acumulador;
figure
plot(t,x)
xlabel('Tiempo [s]')
ylabel('x(t)')
title('Senyal reconstruida')
c_n(N)= -(exp(1i*pi*(1-iter))-1)./((1-iter).*4*pi)+(1i*pi)./(4*pi);
c_n(N+2)= (1i*pi+(exp(-1i*pi*(1+iter))-1)./(1+iter))./(-4*pi);
figure
stem(n,abs(c_n))
xlabel('Numero de coeficiente [k]')
ylabel('|c_n|')
title('Coeficientes del DSF')


P= sum(abs(acumulador).^2)