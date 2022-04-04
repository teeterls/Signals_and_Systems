function [BER] = calculaBER(secuencia_tx,secuencia_rx,PLOT,titulo)
acumulado = 0;
t = linspace(0,length(secuencia_tx),length(secuencia_tx));

for i=1:length(secuencia_tx)
    if(secuencia_rx(i) ~= secuencia_tx(i))
            acumulado=acumulado+1;
    end
end
 BER = acumulado/length(secuencia_tx);
 if(PLOT)
     figure
     stem(t,abs(secuencia_rx-secuencia_tx));
     hold on
     grid on
     title(titulo);
     xlabel('Posición de los Errores');
     ylabel('Errores');
     axis([0 length(secuencia_tx) 0 1]);
end

