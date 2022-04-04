w = linspace(-100*pi,100*pi,1e5);

w_corte = 30; % A elegir por el alumno

s = 1i*w/w_corte 

%----------------   Butterworth
H1 = 1./(s.^4+2.6131*s.^3+3.4142*s.^2+2.6131*s+1);      % Expresión de la respuesta en frecuencia del prototipo ? A RELLENAR 
H2 = 1./(s.^2+1.4142*s+1);

%----------------   Chebyshev
H3 = 0.177./(s.^4+0.5816*s.^3+1.1691*s.^2+0.4048*s+0.177);
H4 = 0.708./(s.^2+0.6449*s+0.708);
max1=max(H3);
max2=max(H4);
H3=H3/max1;
H4=H4/max2;

figure
plot(w,20*log10(abs(H1)))
hold on;
plot(w,20*log10(abs(H2)))
hold on;
plot(w,20*log10(abs(H3)))
hold on;
plot(w,20*log10(abs(H4)))

xlabel('\omega [rad/s]')
ylabel('|H(\omega)| [dB]')
title('Respuesta en frecuencia de diferentes prototipos')
