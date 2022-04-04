function Filtros()
w = linspace(-3000*pi,3000*pi,1e5);

w_corte = 2400*pi; % A elegir por el alumno

s = 1i*w/w_corte;

%----------------
H1 = 1./(s.^2+1.4142.*s+1);
H2 = 1./(s.^2+0.6449*s+0.708);
H3 = 1./(s.^3 +2*(s.^2)+2*s+1);
H4 = 1./(s.^3 +0.5972*(s.^2)+0.9283*s+0.2506);
max1 = max(H1);
max2 = max(H2);
max3= max(H3);
max4 = max(H4);
H1 = H1/(abs(max1));
H2 = H2 / (abs(max2));
H3 = H3 / (abs(max3));
H4 = H4 / (abs(max4));

% Expresión de la respuesta en frecuencia del prototipo ? A RELLENAR 
%----------------
 
figure
plot(w,20*log10(abs(H1)))
xlabel('\omega [rad/s]')
ylabel('|H(\omega)| [dB]')
title('Respuesta en frecuencia del prototipo')
hold on
plot(w,20*log10(abs(H2)))
plot(w,20*log10(abs(H3)))
plot(w,20*log10(abs(H4)))
legend ('H1','H2','H3','H4');
%cogemos la amarilla porque esta justo al bode de 3 db y en la frecuencia
%de corte para el coeficiente 6 = 2400pi. Apenas toca el coeficiente de 1.
%Apenas distorsiona la señal.
end

