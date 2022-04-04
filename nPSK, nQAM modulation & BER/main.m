%% Pr?ctica 6
% 
% Grupo 11
%
% Nombre1 Miguel Oleo Blanco
%
% Nombre2 Teresa Gonz�lez Garc�a

close all; clear all;


%% Ejercicio 1

close all;

m_ary=4; 
nSym=10000*log2(m_ary); %numero de simbolos deseado para que se vean bien las gr?ficas

%Genero la secuencia de bits transmitidos a mano
secuencia_bits_tx = round(rand(1,nSym * log2(m_ary)));

% Convierto los bits serie en palabras de tama?o 2
% bits_symbols sera una matriz de dos columnas y length(secuencia_bits_tx)/2 filas
bits_symbol = reshape(secuencia_bits_tx,2,nSym).';

secuencia_simbolos_tx = zeros(1,nSym); %Pre-allocation del vector de simbolos que devolvera la funcion

%Para QPSK, recorro todas las palabras binarias (bits_symbol) y, dependiendo del valor,
%creo el simbolo de salida
for i= 1:nSym
    %Obtengo la palabra binaria en una cadena de caracteres
    binaryWordStr = num2str(bits_symbol(i,:));
    %Lo transformo a un entero. La variable symbol tendra valores de 0, 1,
    %2 o 3 correspondientes a las palabras binarias 00 01 10 y 11.
    symbol = bin2dec(binaryWordStr) ;
    switch symbol
        case 0
            secuencia_simbolos_tx(i) = 1;
        case 1
            secuencia_simbolos_tx(i) = 1i;  
        case 2
            secuencia_simbolos_tx(i) = -1i;
        case 3
            secuencia_simbolos_tx(i) = -1; 
    end
end

scatterplot(secuencia_simbolos_tx);
%%
% Explicacion:
% La constelaci�n de Q-PSK tiene configuraci�n circular, y tenemos 4
% s�mbolos de dos bits cada uno. Por ello, en la gr�fica salen 4 puntos,
% que se sit�an dos completamente imaginarios los otros dos en plano
% totalmente real. Esto se debe a que en Q-PSK se modula simult�neamente en
% amplitud y frecuencia por lo que la secuencia de s�mbolos tiene
% componentes real e imaginaria, como se puede observar en la gr�fica.

%% Ejercicio 2
% Asumiendo que el Ejercicio 1 se ha realizado correctamente

SNR=5; %dB (probar diferentes valores)
secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR,'measured');
scatterplot(secuencia_simbolos_rx);
title('SNR=5dB');

SNR=10; %dB (probar diferentes valores)
secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR,'measured');
scatterplot(secuencia_simbolos_rx);
title('SNR=10dB');

SNR=15; %dB (probar diferentes valores)
secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR,'measured');
scatterplot(secuencia_simbolos_rx);
title('SNR=15dB');

SNR=20; %dB (probar diferentes valores)
secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR,'measured');
scatterplot(secuencia_simbolos_rx);
title('SNR=20dB');
% Prueba con otros valores de SNR (10 dB, 15 dB, 20 dB)
% Etiquete las gr?ficas adecuadamente para su correcta identificaci?n


%%
% Como se puede observar en las gr�ficas, a menor SNR la BER es mayor. Al
% a�adir el ruido, los puntos resultantes no coinciden con los puntos de la
% constelaci�n del ejercicio anterior. Entonces, para identificar a qu� punto corresponde cada uno,
% ser� mucho m�s f�cil acertar a mayor SNR (20 dB), puesto que los puntos
% resultantes se encuentran m�s cerca del punto de la constelaci�n
% correspondiente. Sin embargo, cuanto m�s peque�a sea SNR (5 dB) es m�s
% dif�cil distinguir a qu� punto corresponde porque se encuentran todos m�s esparcidos, 
% por lo que la BER ser� mayor.

%% Ejercicio 3
% Asumiendo que el Ejercicio 1 se ha realizado correctamente

secuencia_simbolos_rx = secuencia_simbolos_tx; %simulamos que no existe nada de ruido
secuencia_bits_rx = demodQPSK(secuencia_simbolos_rx,nSym);
BER_sin = calculaBER(secuencia_bits_tx,secuencia_bits_rx,true, 'Representacion error sin ruido')

SNR=20; %dB (probar diferentes valores)
secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR,'measured');
secuencia_bits_rx = demodQPSK(secuencia_simbolos_rx,nSym);
BER_20 = calculaBER(secuencia_bits_tx,secuencia_bits_rx,true, 'Representacion error con SNR 20 dB')

SNR=15; %dB (probar diferentes valores)
secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR,'measured');
secuencia_bits_rx = demodQPSK(secuencia_simbolos_rx,nSym);
BER_15 = calculaBER(secuencia_bits_tx,secuencia_bits_rx,true, 'Representacion error con SNR 15 dB')

SNR=10; %dB (probar diferentes valores)
secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR,'measured');
secuencia_bits_rx = demodQPSK(secuencia_simbolos_rx,nSym);
BER_10 = calculaBER(secuencia_bits_tx,secuencia_bits_rx,true,'Representacion error con SNR 10 dB')

SNR=5; %dB (probar diferentes valores)
secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR,'measured');
secuencia_bits_rx = demodQPSK(secuencia_simbolos_rx,nSym);
BER_5 = calculaBER(secuencia_bits_tx,secuencia_bits_rx,true,'Representacion error con SNR 5 dB')

%%
% Primer caso (SNR=0), por lo que BER=0. 
% Segundo caso (SNR=20), se muestra en la gr�fica. BER = 0 aproximadamente.
% Segundo caso (SNR=15), se muestra en la g�fica. BER = 0 aproximadamente.
% Tercer caso (SNR=10), se muestra en la gr�fica. Hay cierto error a
% considerar.
% Cuarto caso (SNR=5), se muestra en la gr�fica. Tienen un error
% mayor.
% La conclusi�n a la que llegamos es que claramente hay una relaci�n entre
% SNR y BER debido a la adici�n de ruido al canal. Si no hay ruido (primer caso), no hay
% probabilidad de error. 
% Sin embargo, a menor relaci�n se�al-ruido (mayor diferencia entre la
% se�al recibida y la transmitida), mayor ser� la probabilidad de error de
% bit puesto que se est� introduciendo mayor ruido en el canal. 
%% Ejercicio 4
% 

close all

SNR = -5:2:20;  %Genero el vector de SNR (o EsN0) en dB
m_ary = 4;  %configuro el tipo de modulacion PSK
 
snr=10.^(SNR/10);
ebn0=snr/log2(m_ary);

%PE es la probabilidad de error de s?mbolo (para la modulacion utilizada) y BER la probabilidad de error
%bit: BER=PE/log2(m_ary) (aprox. cuando se utiliza codificaci?n Gray)

PE = 2*qfunc(sqrt(2*log2(m_ary)*ebn0)*sin(pi/m_ary));
BER_TEORICA=PE/log2(m_ary);
BER_TEORICA(find(BER_TEORICA<1e-5))=NaN;

%Para representar utilizo EbN0 (dB) y la BER en escala logar?tmica, que
%es como suele representarse
EbN0=10*log10(ebn0);
semilogy(EbN0,BER_TEORICA,'-xr')
hold on

%Completar en base al Ejercicio1
%Borre o comente las instrucciones que considere del Ejercicio 1:
%m_ary=4; 
%porque ya est? al comienzo de este script
%scatterplot(secuencia_simbolos_tx); 
%porque no queremos que para este apartado pinte la constelaci?n para cada valor de SNR

nSym=10000*log2(m_ary); %numero de simbolos deseado para que se vean bien las gr?ficas

%Genero la secuencia de bits transmitidos a mano
secuencia_bits_tx = round(rand(1,nSym * log2(m_ary)));

% Convierto los bits serie en palabras de tama?o 2
% bits_symbols sera una matriz de dos columnas y length(secuencia_bits_tx)/2 filas
bits_symbol = reshape(secuencia_bits_tx,2,nSym).';

secuencia_simbolos_tx = zeros(1,nSym); %Pre-allocation del vector de simbolos que devolvera la funcion

%Para QPSK, recorro todas las palabras binarias (bits_symbol) y, dependiendo del valor,
%creo el simbolo de salida
for i= 1:nSym
    %Obtengo la palabra binaria en una cadena de caracteres
    binaryWordStr = num2str(bits_symbol(i,:));
    %Lo transformo a un entero. La variable symbol tendra valores de 0, 1,
    %2 o 3 correspondientes a las palabras binarias 00 01 10 y 11.
    symbol = bin2dec(binaryWordStr) ;
    switch symbol
        case 0
            secuencia_simbolos_tx(i) = 1;
        case 1
            secuencia_simbolos_tx(i) = 1i;  
        case 2
            secuencia_simbolos_tx(i) = -1i;
        case 3
            secuencia_simbolos_tx(i) = -1; 
    end
end



BER_SIMULADA =zeros (1, length(SNR));

for iter_snr=1:length(SNR)

    secuencia_simbolos_rx = awgn(secuencia_simbolos_tx,SNR(iter_snr),'measured');

    secuencia_bits_rx = zeros(1,length(secuencia_simbolos_rx)*2); %preallocation para los bits demodulados

    % Para el caso de QPSK, recorro cada uno de los simbolos recibidos
    for i = 1:nSym
        angulo = angle(secuencia_simbolos_rx(i));
        binaryWord=0;
        %Para cada uno de los simbolos, calculo su angulo y discrimino
        %en cual de los 4 sectores se encuentra. Cuando conozco el
        %sector ya puedo asociar la palabra binaria correspondiente
        if (angulo <= pi/4 && angulo > -pi/4)
            binaryWord = [ 0 0]; 
        elseif (angulo <= 3*pi/4 && angulo > pi/4)
             binaryWord = [0 1];
        elseif (angulo <= -3*pi/4 || angulo > 3*pi/4)
            binaryWord = [1 1];
        elseif (angulo <= -pi/4 && angulo > -3*pi/4)
            binaryWord = [1 0];
        end
        %Relleno el vector de salida (secuencia_bits_rx) con la palabra binaria adjudicada
        %anteriormente. He de colocar la palabra en la posicion correcta.
        secuencia_bits_rx((i-1)*2+1:i*2) = binaryWord;
    end

    BER_SIMULADA (iter_snr) = calculaBER(secuencia_bits_tx,secuencia_bits_rx,false);

end

semilogy(EbN0,BER_SIMULADA,'-o')

grid on
xlabel('EbN0 [dB]')
ylabel('BER')
title('Comportamiento para QPSK')

legend('Simulacion','Teorico')

figure
bar(SNR,BER_SIMULADA);
title('BER para los distintos SNR')
ylabel('BER')
xlabel('SNR')

%%
% En la modulaci�n 4-PSK obtenemos una constelaci�n en forma de
% circunferencia con 4 s�mbolos, 2 bits por s�mbolo. Por lo tanto la
% energ�a media por s�mbolo y por bit es la misma para todos los puntos
% porque se encuentran a la misma distancia del centro (radio). En la f�rmula te�rica la BER (PE/log2M)
% est� relacionada con la SNR (Energia media por bit/No). Para calcular el
% error utilizamos la funci�n Q, en la cual cuanto mayor sea el argumento,
% menor es la probabilidad que encierra la funci�n. Por lo tanto a mayor
% SNR, menor ser� el resultado.
% En la gr�fica obtenida,de escala logar�tmica, se muestra lo esperado: hemos probado varios
% valores de SNR recogidos en un vector (de -5 a 20) y a mayor SNR menor BER. Se puede apreciar, que la BER
% simulada y la te�rica se ajustan bastante.
%
%% Ejercicio 5
close all
m_ary=[2,4,6,8];
n_bits=[4,16,64,256];
SNR=[5,10,15,20];
for i=1:1:length(n_bits)
    for j=1:1:length(SNR)
        BER = Ejercicio5(n_bits(i),SNR(j));
    end
end


%%
% En la modulaciones M-QAM obtenemos una constelaci�n en forma cuadrada con M
% s�mbolos, log2M bits por s�mbolo. En cada constelaci�n los s�mbolos
% resultantes no comparten la misma energ�a media por s�mbolo ni por bit,
% puesto que se encuentran a distancias diferentes al centro. Como muestra
% la f�rmula te�rica, a mayor SNR menor ser� BER debido a la funci�n Q (ya
% explicado). En cada constelaci�n se puede ver c�mo al ir a�adiendo ruido
% ya no coinciden los puntos. Lo que ocurre en cada constelaci�n es que conforme va aumentando la SNR el
% error se va haciendo m�s peque�o por lo que ser� m�s dif�cil equivocarnos
% a qu� s�mbolo pertenece cada punto de la nube. Por ello cuando SNR=5 la
% nube de puntos se encuentra muy dispersa y en SNR=20 los puntos se
% encuentran muy concentrados en la zona correspondiente a cada s�mbolo en
% cuesti�n, haciendo que la probabilidad de que pertenezcan a otro s�mbolo
% diferente sea muy peque�a.
% Adem�s, tambi�n influye M (n�mero de s�mbolos), como puede verse en la
% f�rmula te�rica, ya que a mayor M menor es la distancia entre s�mbolos
% por lo que habr� m�s PE/BER.
%
% Como podemos comprobar, y como vimos en teor�a, a mayor n�mero de
% niveles, necesitamos mayot SNR para mantener la BER (Si no, aumentar�a la
% BER).
%% Ejercicio 6
% 

close all

EbN0_dB = -5:2:25;  %Genero el vector de EbN0 en dB

m_ary = [4,16,64,256];
BER_TEORICA=zeros(length(m_ary), length(EbN0_dB));
BER_SIMULADA=zeros(length(m_ary), length(EbN0_dB));

for j=1:length(m_ary)

    nSym=10000*log2(m_ary(j));

    %%PARA LA BER TEORICA%%%%%%%%%%%%%%%%
    
    ebn0=10.^(EbN0_dB/10);
    snr=ebn0*log2(m_ary(j)); %snr=snr_de_simbolo
    SNR_dB=10*log10(snr);

    %PE es la probabilidad de error de s?mbolo y BER la probabilidad de error
    %de bit: BER=PE/log2(m_ary) (aprox. cuando se utiliza codificaci?n Gray)
    for i=1:length(ebn0)
        PE(i) = 4*(1-1/sqrt(m_ary(j)))*qfunc(sqrt((3*log2(m_ary(j))*ebn0(i))/(m_ary(j)-1)));
    end
    BER_TEORICA(j, :)=PE/log2(m_ary(j));

    %%PARA LA BER SIMULADA%%%%%%%%%%%%%%%

    %Genero bits transmitidos a mano
    secuencia_bits_tx_QAM = round(rand(nSym, 1));

    %Creo el objeto modulador y modulo
    secuencia_simbolos_tx_QAM = qammod(secuencia_bits_tx_QAM, m_ary(j), 'gray', 'InputType','bit');


    for i=1:length(SNR_dB)

        % A?ado ruido
        secuencia_simbolos_rx_QAM = awgn(secuencia_simbolos_tx_QAM,SNR_dB(i),'measured');
        %Creo el objeto demodulador basandome en el modulador y demodulo
        secuencia_bits_rx_QAM = qamdemod(secuencia_simbolos_rx_QAM, m_ary(j),'gray', 'OutputType','bit');
        %Calculo la BER
        BER_SIMULADA (j, i) = calculaBER(secuencia_bits_tx_QAM,secuencia_bits_rx_QAM,false);

    end
    

end


semilogy(EbN0_dB,BER_SIMULADA, '-o')
hold on
BER_TEORICA(find(BER_TEORICA<1e-5))=NaN;
semilogy(EbN0_dB,BER_TEORICA,'-x')

grid on
xlabel('EbN0 [dB]')
ylabel('BER')
title('Comportamiento para QAM')

legendStr = '-QAM [Simu]';
legendStr = repmat(legendStr,length(m_ary),1);
legendStr = [num2str(m_ary(:)) legendStr];
 
legendStr2 = '-QAM [Teor]';
legendStr2 = repmat(legendStr2,length(m_ary),1);
legendStr2 = [num2str(m_ary(:)) legendStr2];
legendStr = [legendStr;legendStr2];
 
legend(legendStr,'Location','Best');

%%
% Hemos probado diferentes modulaciones en cuadratura (como hemos
% explicado en el ejercicio anterior en cada constelaci�n los s�mbolos
% tienen una energ�a y energ�a media distinta puesto que la distancia al
% centro var�a).
%
% Lo que ocurre en cada gr�fica es que conforme va aumentando la SNR el
% error se va haciendo m�s peque�o, por lo que el m�ximo lo encontramos en
% 5 y el m�nimo en 20.
% 
% Este tipo de gr�ficas es muy interesante, ya que si un cliente nos
% pidiese dise�ar un sistema de comunicaci�n usando modulaci�n digital, y
% se valoran distintas modulaciones QAM de distintos niveles, a distintos
% SNR, muy r�pidamente podemos ver las prestaciones de los dise�os para
% cada caso.
%
% Tambi�n es muy importante la gr�fica, ya quue, a un mismo SNR, miramos la
% BER de cada Modulacion QAM, y se pude observar que, a mayor n�mero de
% niveles, mayor es la BER. Esto concuerda con los visto en teor�a, ya que
% la distancia entre simbolos ser� menor, por lo cual es m�s probable que
% confundamos un bit recibido (Aumenta la BER). Aun as�, se utilizan m�s
% niveles en algunas situaciones, ya que ganamos velocidad de transmisi�n
% (R).
% 
% Igual que en el ejercicio 5, para mantener la BER, si aumentamos el
% n�mero de niveles, necesitamos m�s SNR.

