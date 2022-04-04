
%% Ejercicio 1

[cos,temp]=my_coseno(1000,10*10^-6,1000,0,1);

figure
plot(temp.*1000,cos)
hold on
ylabel('Coseno')
xlabel('Tiempo en milisegundos')

%% Ejercicio 2
%%
% 
% * Ejercicio 2.1
    %Calculamos cuantos puntos nos hacen falta para representar 3 ms
    %N=3001
    [cos,temp]=my_coseno(3001,1/(10^6),10*10^3,0,1);
    [cos1,temp1]=my_coseno(3001,1/(10^6),23*10^3,2,2);
    [cos2,temp2]=my_coseno(3001,1/(10^6),7*10^3,1,2);

    coseno=cos+cos1+cos2;
    figure
    plot(temp*1000,coseno)
% * Ejercicio 2.2
    cosf=fft(coseno,length(coseno));
    tiempos= linspace(-2000,2000,3001);
    figure
    stem(tiempos,cosf);
    
% 


